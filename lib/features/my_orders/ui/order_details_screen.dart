import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localization/localization.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/font_weight_helper.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/features/my_orders/data/apis/my_orders_api_constatnts.dart';
import 'package:wardaya/features/my_orders/data/models/my_orders_response.dart';
import 'package:wardaya/features/my_orders/ui/widgets/order_card.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/assets/assets.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      appBar: AppBar(
        title: Text(
          '${context.el.orderNumber} ${order.orderId}',
          style: TextStylesInter.font16BlackSemiBold,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.mainRose,
            size: 18.0.h,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.r),
        child: Column(
          children: [
            OrderCard(order: order),
            const VerticalSpace(height: 16),
            _buildMapPreview(),
            const VerticalSpace(height: 16),
            _buildPaymentDetailsSection(context),
            if (order.giftCard != null) ...[
              const VerticalSpace(height: 16),
              _buildGiftCardSection(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailsSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.black.withAlpha((0.1 * 255).toInt()),
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Text(
              "Payment Details",
              style: TextStylesInter.font16BlackSemiBold,
            ),
          ),
          const Divider(
              height: 1, thickness: 1, color: ColorsManager.lightGrey),
          _buildPaymentDetail(
            "Subtotal",
            "SAR ${order.subtotal.toStringAsFixed(2)}",
            context,
          ),
          _buildPaymentDetail(
            "Delivery charges",
            "SAR ${order.deliveryCharges.toStringAsFixed(2)}",
            context,
          ),
          if (order.vatPercentage > 0)
            _buildPaymentDetail(
              "VAT (${order.vatPercentage}%)",
              "SAR ${(order.subtotal * (order.vatPercentage / 100)).toStringAsFixed(2)}",
              context,
            ),
          const Divider(
              height: 1, thickness: 1, color: ColorsManager.lightGrey),
          _buildPaymentDetail(
            "Total",
            "SAR ${order.total.toStringAsFixed(2)}",
            context,
            isTotal: true,
          ),
          const Divider(
              height: 1, thickness: 1, color: ColorsManager.lightGrey),
          _buildPaymentDetail(
            "Payment Method",
            order.paymentMethod.toUpperCase(),
            context,
          ),
        ],
      ),
    );
  }

  Widget _buildMapPreview() {
    final latitude = order.deliveryInfo.shipping.latitude.toDouble();
    final longitude = order.deliveryInfo.shipping.longitude.toDouble();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.r),
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: ColorsManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorsManager.black.withAlpha((0.1 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              rotateGesturesEnabled: false,
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false,
              tiltGesturesEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 15,
              ),
              markers: {
                gmaps.Marker(
                  markerId: const gmaps.MarkerId('delivery_location'),
                  position: gmaps.LatLng(latitude, longitude),
                ),
              },
            ),
            Positioned.fill(
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGiftCardSection(BuildContext context) {
    final giftCard = order.giftCard;
    if (giftCard == null) return const SizedBox.shrink();

    if (giftCard.template != null) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.white,
                    border: Border.all(
                      color: ColorsManager.mainRose,
                      width: 1.5,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            Assets.of(context).svgs.small_logo_svg,
                            height: 15.h,
                            width: 15.w,
                          ),
                          VerticalSpace(height: 4.h),
                          if (!giftCard.to.isNullOrEmpty())
                            Text(
                              giftCard.to!,
                              style:
                                  TextStylesInter.font14BlackSemiBold.copyWith(
                                fontWeight: FontWeightHelper.regular,
                              ),
                            ),
                          VerticalSpace(height: 4.h),
                          if (!giftCard.message.isNullOrEmpty())
                            Text(
                              giftCard.message!,
                              style:
                                  TextStylesInter.font14BlackSemiBold.copyWith(
                                fontWeight: FontWeightHelper.regular,
                              ),
                            ),
                          VerticalSpace(height: 4.h),
                          if (!giftCard.from.isNullOrEmpty())
                            Text(
                              giftCard.from!,
                              style: giftCard.handwriting == true
                                  ? TextStylesEBGaramond.font12MainRoseBold
                                      .copyWith(
                                      fontSize: 14.sp,
                                      color: ColorsManager.black,
                                      fontWeight: FontWeightHelper.regular,
                                    )
                                  : TextStylesInter.font14BlackSemiBold
                                      .copyWith(
                                      fontWeight: FontWeightHelper.regular,
                                    ),
                            ),
                          if (giftCard.signatureImageUrl != null)
                            CachedNetworkImage(
                              imageUrl:
                                  MyOrdersApiConstants.apiBaseUrlForImage +
                                      giftCard.signatureImageUrl!,
                              height: 50.h,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          VerticalSpace(height: 8.h),
                          if (!giftCard.link.isNullOrEmpty())
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorsManager.mainRose
                                    .withAlpha((0.3 * 255).toInt()),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.r),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 32.h,
                                      width: 35.w,
                                      padding: EdgeInsets.all(2.r),
                                      decoration: BoxDecoration(
                                        color: ColorsManager.white,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                      child: QrImageView(
                                        data: giftCard.link!,
                                        size: 30.w,
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            context.el.qrCodeLabel,
                                            style: TextStylesInter
                                                .font10WhiteBold
                                                .copyWith(
                                              fontSize: 8.sp,
                                              color: ColorsManager.mainRose,
                                              fontWeight:
                                                  FontWeightHelper.semiBold,
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Text(
                                            context.el.qrCodeNote,
                                            style: TextStylesInter
                                                .font10WhiteBold
                                                .copyWith(
                                              fontSize: 8.sp,
                                              color: ColorsManager.mainRose,
                                              fontWeight:
                                                  FontWeightHelper.semiBold,
                                            ),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            if (giftCard.template?.image != null)
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    imageUrl: giftCard.template!.image.startsWith('http')
                        ? giftCard.template!.image
                        : MyOrdersApiConstants.apiBaseUrlForImage +
                            giftCard.template!.image,
                    height: 150.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildPaymentDetail(String label, String value, BuildContext context,
      {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? TextStylesInter.font14BlackSemiBold
                : TextStylesInter.font14GreyRegular,
          ),
          Text(
            value,
            style: isTotal
                ? TextStylesInter.font14MainRoseSemiBold
                : TextStylesInter.font14BlackRegular,
          ),
        ],
      ),
    );
  }
}
