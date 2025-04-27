import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/core/widgets/app_app_bar.dart';
import 'package:wardaya/features/invoices/data/apis/invoices_api_constants.dart';
import 'package:wardaya/features/invoices/data/models/invoice_response.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  final InvoiceItem invoice;

  const InvoiceDetailsScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    // Format dates
    final dateFormat = DateFormat('dd MMM, yyyy', 'en_US');
    final timeFormat = DateFormat('hh:mm a', 'en_US');
    final invoiceDate = dateFormat.format(invoice.invoiceDate);
    final invoiceTime = timeFormat.format(invoice.invoiceDate);

    // Extract order details if available
    final hasOrderDetails = invoice.orderID.isNotEmpty;
    final orderItem = hasOrderDetails ? invoice.orderID.first : null;
    final orderId = orderItem?.orderId ?? 'N/A';
    final orderStatus = orderItem?.status ?? 'N/A';
    final paymentMethod = orderItem?.paymentMethod ?? 'N/A';

    // Access delivery and gift card info directly from the order item
    final deliveryInfo = orderItem?.deliveryInfo;
    final giftCardInfo = orderItem?.giftCard;

    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      appBar: AppAppBar(title: context.el.invoices),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Invoice Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0.w),
                decoration: BoxDecoration(
                  color: ColorsManager.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color:
                          ColorsManager.black.withAlpha((0.05 * 255).toInt()),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Invoice ID and Date
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Invoice #${invoice.id.substring(invoice.id.length - 8)}',
                          style: TextStylesInter.font16BlackSemiBold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          '$invoiceDate • $invoiceTime',
                          style: TextStylesInter.font14GreyRegular,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Total Amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount:',
                          style: TextStylesInter.font14BlackRegular,
                        ),
                        Text(
                          '${invoice.currency} ${invoice.totalPrice.toStringAsFixed(2)}',
                          style: TextStylesInter.font16BlackSemiBold.copyWith(
                            color: ColorsManager.mainRose,
                          ),
                        ),
                      ],
                    ),

                    // Order ID
                    if (orderId != 'N/A') ...[
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order ID:',
                            style: TextStylesInter.font14BlackRegular,
                          ),
                          Text(
                            orderId,
                            style: TextStylesInter.font14BlackSemiBold,
                          ),
                        ],
                      ),
                    ],

                    // Order Status
                    if (orderStatus != 'N/A') ...[
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Status:',
                            style: TextStylesInter.font14BlackRegular,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: getStatusColor(orderStatus),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              orderStatus.toUpperCase(),
                              style: TextStylesInter.font12WhiteBold,
                            ),
                          ),
                        ],
                      ),
                    ],

                    // Payment Method
                    if (paymentMethod != 'N/A') ...[
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Payment Method:',
                            style: TextStylesInter.font14BlackRegular,
                          ),
                          Text(
                            paymentMethod,
                            style: TextStylesInter.font14BlackSemiBold,
                          ),
                        ],
                      ),
                    ],

                    // Order Date
                    if (orderItem?.date != null) ...[
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order Date:',
                            style: TextStylesInter.font14BlackRegular,
                          ),
                          Text(
                            dateFormat.format(orderItem!.date!),
                            style: TextStylesInter.font14BlackSemiBold,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Customer Information
              if (invoice.name.isNotEmpty || invoice.email.isNotEmpty)
                _buildSectionCard(
                  title: 'Customer Information',
                  child: Column(
                    children: [
                      _buildDetailRow('Name', invoice.name),
                      SizedBox(height: 8.h),
                      _buildDetailRow('Email', invoice.email),
                      if (invoice.phoneNumber.isNotEmpty) ...[
                        SizedBox(height: 8.h),
                        _buildDetailRow('Phone', invoice.phoneNumber),
                      ],
                    ],
                  ),
                ),

              SizedBox(height: 16.h),

              // Delivery Information
              if (deliveryInfo != null)
                _buildSectionCard(
                  title: 'Delivery Information',
                  child: Column(
                    children: [
                      _buildDetailRow('Recipient', deliveryInfo.name ?? 'N/A'),
                      SizedBox(height: 8.h),
                      _buildDetailRow('Phone',
                          '${deliveryInfo.countryCode ?? ''} ${deliveryInfo.phone ?? 'N/A'}'),
                      SizedBox(height: 8.h),
                      _buildDetailRow('Express Delivery',
                          deliveryInfo.expressDelivery == true ? 'Yes' : 'No'),
                      SizedBox(height: 8.h),
                      _buildDetailRow(
                          'Keep Identity Secret',
                          deliveryInfo.keepIdentitySecret == true
                              ? 'Yes'
                              : 'No'),
                      if (deliveryInfo.deliveryTime != null) ...[
                        SizedBox(height: 8.h),
                        _buildDetailRow(
                          'Delivery Time',
                          dateFormat.format(deliveryInfo.deliveryTime!),
                        ),
                      ],
                    ],
                  ),
                ),

              SizedBox(height: 16.h),

              // Gift Card Information
              if (giftCardInfo != null)
                _buildSectionCard(
                  title: 'Gift Card Information',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('To', giftCardInfo.to ?? 'N/A'),
                      VerticalSpace(
                        height: 8.h,
                      ),
                      _buildDetailRow('From', giftCardInfo.from ?? 'N/A'),
                      VerticalSpace(
                        height: 8.h,
                      ),
                      _buildDetailRow('Message', giftCardInfo.message ?? 'N/A'),
                      VerticalSpace(
                        height: 8.h,
                      ),
                      _buildDetailRow('Handwriting',
                          giftCardInfo.handwriting == true ? 'Yes' : 'No'),

                      // Display Gift Card Image using link or qrImageUrl
                      if (giftCardInfo.link != null ||
                          giftCardInfo.qrImageUrl != null) ...[
                        VerticalSpace(
                          height: 16.h,
                        ),
                        Text(
                          'Gift Card Image:',
                          style: TextStylesInter.font14BlackRegular,
                        ),
                        VerticalSpace(
                          height: 8.h,
                        ),
                        // Center(
                        // child: CachedNetworkImage(
                        //   imageUrl: InvoicesApiConstants.apiBaseUrlForImages +
                        //       giftCardInfo.template.,
                        //   height: 80.h,
                        //   width: double.infinity,
                        //   fit: BoxFit.contain,
                        //   placeholder: (context, url) => const Center(
                        //     child: CircularProgressIndicator(
                        //       color: ColorsManager.mainRose,
                        //     ),
                        //   ),
                        //   errorWidget: (context, url, error) =>
                        //       SvgPicture.asset(
                        //     Assets.of(context).svgs.small_logo_svg,
                        //     height: 60.h,
                        //     width: 60.w,
                        //     colorFilter: const ColorFilter.mode(
                        //       Colors.grey,
                        //       BlendMode.srcIn,
                        //     ),
                        //   ),
                        // ),
                        // ),
                        Container(
                          height: 80.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorsManager.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 80.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: ColorsManager.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: QrImageView(
                                    data:
                                        !giftCardInfo.qrImageUrl.isNullOrEmpty()
                                            ? giftCardInfo.qrImageUrl!
                                            : (giftCardInfo.link ?? '')),
                              )
                            ],
                          ),
                        ),
                      ],

                      // Display signature image if available
                      if (giftCardInfo.signatureImageUrl != null) ...[
                        VerticalSpace(
                          height: 16.h,
                        ),
                        Text(
                          'Signature:',
                          style: TextStylesInter.font14BlackRegular,
                        ),
                        VerticalSpace(
                          height: 8.h,
                        ),
                        Center(
                          child: CachedNetworkImage(
                            imageUrl: InvoicesApiConstants.apiBaseUrlForImages +
                                giftCardInfo.signatureImageUrl!,
                            height: 60.h,
                            width: double.infinity,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: ColorsManager.mainRose,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                SvgPicture.asset(
                              Assets.of(context).svgs.small_logo_svg,
                              height: 60.h,
                              width: 60.w,
                              colorFilter: const ColorFilter.mode(
                                Colors.grey,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

              SizedBox(height: 16.h),

              // Order Pricing Breakdown
              if (orderItem != null &&
                  (orderItem.subtotal != null ||
                      orderItem.deliveryCharges != null ||
                      orderItem.vatPercentage != null))
                _buildSectionCard(
                  title: 'Order Summary',
                  child: Column(
                    children: [
                      if (orderItem.subtotal != null) ...[
                        _buildPriceRow(
                            'Subtotal', orderItem.subtotal!, invoice.currency),
                        SizedBox(height: 8.h),
                      ],
                      if (orderItem.deliveryCharges != null) ...[
                        _buildPriceRow('Delivery Charges',
                            orderItem.deliveryCharges!, invoice.currency),
                        SizedBox(height: 8.h),
                      ],
                      if (orderItem.subtotal != null &&
                          orderItem.vatPercentage != null) ...[
                        _buildPriceRow(
                            'VAT (${orderItem.vatPercentage}%)',
                            _calculateVAT(
                                orderItem.subtotal!, orderItem.vatPercentage!),
                            invoice.currency),
                        SizedBox(height: 16.h),
                      ],
                      const Divider(color: ColorsManager.lightGrey),
                      SizedBox(height: 8.h),
                      _buildPriceRow(
                          'Total', invoice.totalPrice, invoice.currency,
                          isTotal: true),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Calculate VAT amount
  double _calculateVAT(double subtotal, double vatPercentage) {
    return (subtotal * vatPercentage / 100);
  }

  // Helper method to build section card
  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStylesInter.font16BlackSemiBold.copyWith(
              color: ColorsManager.mainRose,
            ),
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  // Helper method to build detail row
  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: TextStylesInter.font14BlackRegular,
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: TextStylesInter.font14BlackSemiBold,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  // Helper method to build price row
  Widget _buildPriceRow(String label, num amount, String currency,
      {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? TextStylesInter.font16BlackSemiBold
              : TextStylesInter.font14BlackRegular,
        ),
        Text(
          '$currency ${amount.toStringAsFixed(2)}',
          style: isTotal
              ? TextStylesInter.font16BlackSemiBold.copyWith(
                  color: ColorsManager.mainRose,
                )
              : TextStylesInter.font14BlackSemiBold,
        ),
      ],
    );
  }

  // Helper method to get color based on status
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.blue;
      case 'processing':
        return Colors.orange;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return ColorsManager.mainRose;
    }
  }
}
