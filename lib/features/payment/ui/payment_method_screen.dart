import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/widgets/app_app_bar.dart';

import 'tap_payment_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double amount;

  const PaymentMethodScreen({
    super.key,
    required this.amount,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? _selectedPaymentMethodId;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppAppBar(title: context.el.paymentMethodsTitle),
      body: Column(
        children: [
          // Payment amount header
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: ColorsManager.offWhite,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ColorsManager.lightGrey),
              ),
              child: Column(
                children: [
                  Text(
                    context.el.paymentAmountTitle,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.mainRose,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'SAR ${widget.amount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Payment methods list
          Expanded(
            child: PaymentMethodsList(
              selectedPaymentMethodId: _selectedPaymentMethodId,
              onPaymentMethodSelected: (id) {
                setState(() {
                  _selectedPaymentMethodId = id;
                });
              },
            ),
          ),

          // Proceed to payment button
          Padding(
            padding: EdgeInsets.all(16.r),
            child: ElevatedButton(
              onPressed: _selectedPaymentMethodId == null || _isProcessing
                  ? null
                  : () => _proceedToPayment(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainRose,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade300,
                minimumSize: Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: _isProcessing
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      context.el.proceedToPaymentButton,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _proceedToPayment(BuildContext context) async {
    if (_selectedPaymentMethodId == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      bool paymentSuccess = false;

      // Handle different payment methods
      // For all other payment methods, use the new Tap Payment screen
      paymentSuccess = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TapPaymentScreen(
                amount: widget.amount,
                // orderId: widget.orderId,
                paymentMethod: _selectedPaymentMethodId,
              ),
            ),
          ) ??
          false;

      // Handle payment result
      if (paymentSuccess) {
        // Show success message and navigate back
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment successful!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(
              context, true); // Return to previous screen with success result
        }
      }
    } catch (e) {
      // Handle errors
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }
}

class PaymentMethodsList extends StatelessWidget {
  final String? selectedPaymentMethodId;
  final Function(String) onPaymentMethodSelected;

  const PaymentMethodsList({
    super.key,
    required this.selectedPaymentMethodId,
    required this.onPaymentMethodSelected,
  });

  List<PaymentMethodOption> _getPaymentMethods(BuildContext context) {
    return [
      PaymentMethodOption(
        id: 'card',
        title: context.el.creditDebitCardTitle,
        description: context.el.creditDebitCardDescription,
        icon: 'assets/pay_cards/master_card.png',
      ),
      PaymentMethodOption(
        id: 'mada',
        title: context.el.madaTitle,
        description: context.el.madaDescription,
        icon: 'assets/pay_cards/mada.png',
      ),
      PaymentMethodOption(
        id: 'apple_pay',
        title: context.el.applePayTitle,
        description: context.el.applePayDescription,
        icon: 'assets/svgs/apple.svg',
        isSvg: true,
        isApplePay: true,
      ),
      PaymentMethodOption(
        id: 'google_pay',
        title: context.el.googlePayTitle,
        description: context.el.googlePayDescription,
        icon: 'assets/pay_cards/gpay.png',
      ),
      PaymentMethodOption(
        id: 'benefitpay',
        title: context.el.benefitPayTitle,
        description: context.el.benefitPayDescription,
        icon: 'assets/pay_cards/master_card.png',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final paymentMethods = _getPaymentMethods(context);

    return ListView.builder(
      itemCount: paymentMethods.length,
      padding: EdgeInsets.all(16.r),
      itemBuilder: (context, index) {
        final method = paymentMethods[index];
        final isSelected = method.id == selectedPaymentMethodId;

        // Check if we should show Apple Pay (only on iOS)
        if (method.isApplePay &&
            Theme.of(context).platform != TargetPlatform.iOS) {
          return const SizedBox.shrink();
        }

        // Check if we should show Google Pay (only on Android)
        if (method.id == 'google_pay' &&
            Theme.of(context).platform != TargetPlatform.android) {
          return const SizedBox.shrink();
        }

        return PaymentMethodCard(
          method: method,
          isSelected: isSelected,
          onTap: () => onPaymentMethodSelected(method.id),
        );
      },
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethodOption method;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsManager.mainRose.withAlpha((0.1 * 255).toInt())
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color:
                isSelected ? ColorsManager.mainRose : ColorsManager.lightGrey,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SizedBox(
                width: 48.w,
                height: 48.w,
                child: method.isSvg
                    ? SvgPicture.asset(
                        method.icon,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        method.icon,
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.title,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    method.description,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? ColorsManager.mainRose
                      : ColorsManager.lightGrey,
                  width: 2,
                ),
                color: Colors.white,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorsManager.mainRose,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodOption {
  final String id;
  final String title;
  final String description;
  final String icon;
  final bool isApplePay;
  final bool isSvg;

  PaymentMethodOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.isApplePay = false,
    this.isSvg = false,
  });
}
