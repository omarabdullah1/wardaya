import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/widgets/app_app_bar.dart';

import '../../../core/routing/routes.dart';
import '../../../core/widgets/loading_widget.dart';

class TapPaymentScreen extends StatefulWidget {
  final double amount;
  final String orderId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String countryCode;
  final String? paymentMethod;
  final String? redirectUrl; // Add redirectUrl parameter

  const TapPaymentScreen({
    super.key,
    required this.amount,
    required this.orderId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber = "",
    this.countryCode = "+966",
    this.paymentMethod,
    this.redirectUrl, // Add to constructor
  });

  @override
  State<TapPaymentScreen> createState() => _TapPaymentScreenState();
}

class _TapPaymentScreenState extends State<TapPaymentScreen> {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = "";
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize platform-specific WebView
    _initWebView();
  }

  void _initWebView() {
    try {
      // Initialize the controller based on platform
      late final PlatformWebViewControllerCreationParams params;

      WebViewPlatform.instance ??= AndroidWebViewPlatform();

      params = const PlatformWebViewControllerCreationParams();

      _controller = WebViewController.fromPlatformCreationParams(params);

      // Configure the controller
      _controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              log('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              log('Page started loading: $url');
              setState(() {
                _isLoading = true;
              });
              // Check if the URL contains 'wardaya.net' to determine payment status
              if (url.contains('wardaya.net')) {
                log('Redirect to wardaya.net detected: $url');
                bool isSuccess =
                    !url.contains('error') && !url.contains('cancel');
                _showResultDialog(isSuccess);
              }
            },
            onPageFinished: (String url) {
              log('Page finished loading: $url');
              setState(() {
                _isLoading = false;
              });

              // Check if the URL contains 'wardaya.net' to determine payment status
              if (url.contains('wardaya.net')) {
                log('Redirect to wardaya.net detected: $url');
                bool isSuccess =
                    !url.contains('error') && !url.contains('cancel');
                _showResultDialog(isSuccess);
              }
            },
            onWebResourceError: (WebResourceError error) {
              log('WebView error: ${error.description}');
              // Only show errors for significant issues
              if (error.errorCode != -1) {
                setState(() {
                  _isError = true;
                  _errorMessage =
                      'Error loading payment page: ${error.description}';
                  _isLoading = false;
                });
              }
            },
          ),
        );

      // Load the URL from the widget if provided, otherwise use default
      _loadUrl();
    } catch (e) {
      log('Error initializing WebView: $e');
      setState(() {
        _isError = true;
        _errorMessage = 'Error initializing WebView: $e';
        _isLoading = false;
      });
    }
  }

  void _loadUrl() {
    try {
      final url = widget.redirectUrl;
      _controller.loadRequest(Uri.parse(url!));
    } catch (e) {
      log('Error loading URL: $e');
      setState(() {
        _isError = true;
        _errorMessage = 'Error loading payment page: $e';
        _isLoading = false;
      });
    }
  }

  void _showResultDialog(bool isSuccess) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(isSuccess
            ? context.el.paymentSuccessTitle
            : context.el.paymentFailedTitle),
        content: Text(
          isSuccess
              ? context.el.paymentSuccessMessage
              : context.el.paymentFailedMessage,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pushReplacementNamed(Routes.homeLayout);
            },
            child: Text(context.el.paymentOkButton),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(
        title: context.el.paymentTitle,
        onBackButtonPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(context.el.cancelPaymentTitle),
              content: Text(context.el.cancelPaymentMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.el.cancelPaymentNo),
                ),
                TextButton(
                  onPressed: () {
                    context.pushReplacementNamed(Routes.homeLayout);
                  },
                  child: Text(context.el.cancelPaymentYes),
                ),
              ],
            ),
          );
        },
      ),
      body: Column(
        children: [
          // Payment amount header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
                    context.el.paymentAmountTitle,
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.mainRose,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'SAR ${widget.amount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: ColorsManager.mainRose,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${context.el.paymentOrderIdLabel} ${widget.orderId}',
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

          // Loading indicator
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: LoadingWidget(loadingState: true),
              ),
            ),

          // Error message
          if (_isError)
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: ColorsManager.red.withAlpha((0.1 * 255).toInt()),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: ColorsManager.red,
                      size: 32,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '${context.el.paymentError} $_errorMessage',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: ColorsManager.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isError = false;
                          _isLoading = true;
                        });
                        _initWebView();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.mainRose,
                      ),
                      child: Text(context.el.paymentTryAgain),
                    ),
                  ],
                ),
              ),
            ),

          // WebView
          if (!_isError)
            Expanded(
              child: WebViewWidget(controller: _controller),
            ),
        ],
      ),
    );
  }
}
