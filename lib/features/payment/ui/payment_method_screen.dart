import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/widgets/app_app_bar.dart';

import 'benefit_pay_screen.dart';
import 'tap_payment_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  final double amount;
  final String orderId;

  const PaymentMethodScreen({
    super.key,
    required this.amount,
    required this.orderId,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final List<PaymentMethodOption> _paymentMethods = [
    PaymentMethodOption(
      id: 'card',
      title: 'Credit/Debit Card',
      description: 'Pay with Visa, Mastercard, or other cards',
      icon: 'assets/pay_cards/master_card.png',
    ),
    PaymentMethodOption(
      id: 'mada',
      title: 'Mada',
      description: 'Pay with Mada debit card',
      icon: 'assets/pay_cards/mada.png',
    ),
    PaymentMethodOption(
      id: 'apple_pay',
      title: 'Apple Pay',
      description: 'Quick and secure payment with Apple Pay',
      icon:
          'assets/svgs/apple.svg', // Using existing SVG instead of missing PNG
      isSvg: true,
      isApplePay: true,
    ),
    PaymentMethodOption(
      id: 'google_pay',
      title: 'Google Pay',
      description: 'Quick and secure payment with Google Pay',
      icon: 'assets/pay_cards/gpay.png',
    ),
    PaymentMethodOption(
      id: 'benefitpay',
      title: 'Benefit Pay',
      description: 'Pay using Benefit Pay service',
      icon:
          'assets/pay_cards/master_card.png', // Fallback to a generic payment icon
    ),
  ];

  String? _selectedPaymentMethodId;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: const AppAppBar(
          title: 'context.el.paymentMethodsTitle' ?? 'Payment Methods'),
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
                    'context.el.paymentAmountTitle' ?? 'Payment Amount',
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
            child: ListView.builder(
              itemCount: _paymentMethods.length,
              padding: EdgeInsets.all(16.r),
              itemBuilder: (context, index) {
                final method = _paymentMethods[index];
                final isSelected = method.id == _selectedPaymentMethodId;

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

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPaymentMethodId = method.id;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ColorsManager.mainRose
                              .withAlpha((0.1 * 255).toInt())
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected
                            ? ColorsManager.mainRose
                            : ColorsManager.lightGrey,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Payment method icon
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

                        // Payment method details
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

                        // Selection indicator
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
                      'context.el.proceedToPaymentButton' ??
                          'Proceed to Payment',
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
      if (_selectedPaymentMethodId == 'benefitpay') {
        // Use BenefitPay specific screen
        paymentSuccess = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BenefitPayScreen(
                  amount: widget.amount,
                  orderId: widget.orderId,
                ),
              ),
            ) ??
            false;
      } else {
        // For all other payment methods, use the new Tap Payment screen
        paymentSuccess = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TapPaymentScreen(
                  amount: widget.amount,
                  orderId: widget.orderId,
                  firstName: "John", // Replace with actual user data
                  lastName: "Smith", // Replace with actual user data
                  email:
                      "customer@example.com", // Replace with actual user data
                  phoneNumber: "566123456", // Replace with actual user data
                  countryCode: "+966", // Replace with actual user data
                  paymentMethod: _selectedPaymentMethodId,
                ),
              ),
            ) ??
            false;
      }

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
