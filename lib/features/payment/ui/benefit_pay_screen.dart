import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:benefit_pay_flutter/benefit_pay_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/widgets/app_app_bar.dart';
import '../service/payment_service.dart';

class BenefitPayScreen extends StatefulWidget {
  final double amount;
  final String orderId;

  const BenefitPayScreen({
    super.key,
    required this.amount,
    required this.orderId,
  });

  @override
  State<BenefitPayScreen> createState() => _BenefitPayScreenState();
}

class _BenefitPayScreenState extends State<BenefitPayScreen> {
  late Map<String, dynamic> sdkConfiguration;
  String sdkResponse = "";
  bool isProcessing = false;
  // Use a UniqueKey instead of a GlobalKey for better disposal behavior
  final UniqueKey _benefitPayKey = UniqueKey();
  // Flag to track if we should show the widget
  bool _showBenefitPayWidget = true;

  @override
  void initState() {
    super.initState();
    // Initialize the configuration with more realistic customer name values
    sdkConfiguration = PaymentService.createBenefitPayConfig(
      amount: widget.amount,
      currency: "SAR",
      orderId: widget.orderId,
      firstName: "John", // Use a real first name instead of "TAP"
      lastName: "Smith", // Use a real last name instead of "PAYMENTS"
      customerEmail: "customer@example.com", // More realistic email
      customerPhone: "566123456", // More realistic Saudi phone number format
      transactionReference: "TR-${widget.orderId}",
    );

    // Explicitly add the payment method to the configuration
    sdkConfiguration["paymentMethod"] = "benefitpay";

    // Log the configuration to check its format
    log("BenefitPay Configuration: ${sdkConfiguration.toString()}");

    // Attempt to recreate widget after a short delay to avoid initial rendering issues
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showBenefitPayWidget = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // Ensure proper cleanup
    _showBenefitPayWidget = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppAppBar(title: 'context.el.paymentTitle' ?? 'Payment'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Payment amount display
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: ColorsManager.offWhite,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: ColorsManager.lightGrey, width: 1),
                ),
                child: Column(
                  children: [
                    Text(
                      'context.el.paymentAmountTitle' ?? 'Payment Amount',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.mainRose,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '${context.el.currencySar} ${widget.amount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: ColorsManager.mainRose,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'context.el.orderIdLabel' ??
                          'Order ID: ${widget.orderId}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Payment status message
            if (sdkResponse.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: sdkResponse.contains('success')
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    sdkResponse,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: sdkResponse.contains('success')
                          ? Colors.green
                          : Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

            // Processing indicator
            if (isProcessing)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: const CircularProgressIndicator(
                  color: ColorsManager.mainRose,
                ),
              ),

            const Spacer(),

            // BenefitPay payment button
            Padding(
              padding: EdgeInsets.all(20.r),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: _showBenefitPayWidget
                    ? TapBenefitPayWidget(
                        key: _benefitPayKey, // Assign the unique key
                        sdkConfiguration: sdkConfiguration,
                        onReady: () {
                          log("BenefitPay SDK is Ready");
                          if (mounted) {
                            setState(() {
                              isProcessing = false;
                            });
                          }
                        },
                        onClick: () {
                          log("BenefitPay button clicked");
                          if (mounted) {
                            setState(() {
                              isProcessing = true;
                              sdkResponse = "";
                            });
                          }
                        },
                        onCancel: () {
                          log("Payment was cancelled");
                          if (mounted) {
                            setState(() {
                              isProcessing = false;
                              sdkResponse = "Payment was cancelled";
                            });
                          }
                        },
                        onSuccess: (String? response) {
                          log("Payment success: $response");
                          if (mounted) {
                            setState(() {
                              isProcessing = false;
                              sdkResponse = "Payment successful: $response";
                            });

                            // Here you would typically handle successful payment
                            // For example, navigate back to confirmation page
                            Future.delayed(const Duration(seconds: 2), () {
                              if (mounted) {
                                Navigator.pop(context,
                                    true); // Return true to indicate success
                              }
                            });
                          }
                        },
                        onError: (String? error) {
                          log("Payment error: $error");
                          if (mounted) {
                            setState(() {
                              isProcessing = false;
                              sdkResponse = "Payment error: $error";
                            });

                            // Only recreate widget if specific error occurs
                            if (error?.contains(
                                    "Customer first name is required") ==
                                true) {
                              // Wait a moment before attempting to recreate
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                if (mounted) {
                                  setState(() {
                                    _showBenefitPayWidget = false;
                                  });

                                  Future.delayed(
                                      const Duration(milliseconds: 300), () {
                                    if (mounted) {
                                      setState(() {
                                        _showBenefitPayWidget = true;
                                      });
                                    }
                                  });
                                }
                              });
                            }
                          }
                        },
                        onOrderCreated: (String? orderId) {
                          log("Order created: $orderId");
                        },
                        onChargeCreated: (String? charge) {
                          log("Charge created: $charge");
                        },
                      )
                    : Container(
                        // Placeholder when the widget is being reloaded
                        color: ColorsManager.offWhite,
                        child: Center(
                          child: Text(
                            'Initializing payment...',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: ColorsManager.grey,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
