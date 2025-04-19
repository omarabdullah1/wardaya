import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/routing/routes.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/font_weight_helper.dart';
import 'package:wardaya/features/my_occasions/data/apis/my_occassions_api_constatnts.dart';
import 'package:wardaya/features/my_orders/data/models/my_orders_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/core/helpers/spacing.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  String _formatOrderNumber(String orderId) {
    return orderId.replaceAll('ORD-', '#');
  }

  Widget _buildTotalPrice(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: const BoxDecoration(
        color: ColorsManager.lighterGrey,
        border: Border(
          top: BorderSide(color: ColorsManager.lightGrey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.el.total,
            style: TextStylesInter.font16BlackSemiBold,
          ),
          Text(
            '${context.el.currencySar}${NumberFormat("#,##0").format(order.total)}',
            style: TextStylesInter.font16MainRoseBold,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.pushNamed(Routes.orderDetailsScreen, arguments: order),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            _buildOrderHeader(context),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.r),
              itemCount:
                  order.products.where((p) => p.productId != null).length,
              separatorBuilder: (context, index) => Divider(
                  height: 24.h, thickness: 1, color: ColorsManager.lightGrey),
              itemBuilder: (context, index) {
                final orderProduct = order.products
                    .where((p) => p.productId != null)
                    .toList()[index];
                if (orderProduct.productId == null) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: CachedNetworkImage(
                            imageUrl: MyOrdersApiConstants.apiBaseUrlForImage +
                                (orderProduct.productId?.images.firstOrNull ??
                                    ''),
                            width: 80.w,
                            height: 80.w,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: ColorsManager.mainRose,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                SvgPicture.asset(
                              Assets.of(context).svgs.small_logo_svg,
                              width: 80.w,
                              height: 80.w,
                              fit: BoxFit.contain,
                              colorFilter: const ColorFilter.mode(
                                ColorsManager.grey,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        const HorizontalSpace(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderProduct.productId?.title ?? '',
                                style: TextStylesInter.font16BlackSemiBold,
                              ),
                              const VerticalSpace(height: 4),
                              Text(
                                'x${orderProduct.quantity}',
                                style: TextStylesInter.font14GreyRegular,
                              ),
                              const VerticalSpace(height: 8),
                              Text(
                                'SAR ${NumberFormat("#,##0").format(orderProduct.price)}',
                                style: TextStylesInter.font16MainRoseBold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            if (order.giftCard?.template != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                        height: 24.h,
                        thickness: 1,
                        color: ColorsManager.lightGrey),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.r),
                          child: CachedNetworkImage(
                            imageUrl: order.giftCard?.template?.image ?? '',
                            width: 80.w,
                            height: 80.w,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: ColorsManager.mainRose,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                SvgPicture.asset(
                              Assets.of(context).svgs.small_logo_svg,
                              width: 80.w,
                              height: 80.w,
                              fit: BoxFit.contain,
                              colorFilter: const ColorFilter.mode(
                                ColorsManager.grey,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        const HorizontalSpace(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.giftCard?.template?.name ?? '',
                                style: TextStylesInter.font16BlackSemiBold,
                              ),
                              const VerticalSpace(height: 8),
                              Text(
                                'SAR ${order.giftCard?.template?.price.total ?? 0}',
                                style: TextStylesInter.font16MainRoseBold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            _buildTotalPrice(context),
            const Divider(
                height: 1, thickness: 1, color: ColorsManager.lightGrey),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: _buildOrderInfo(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatOrderNumber(order.orderId),
                style: TextStylesInter.font16BlackSemiBold,
              ),
              const VerticalSpace(height: 4),
              Text(
                _formatDate(order.date),
                style: TextStylesInter.font14GreyRegular,
              ),
            ],
          ),
          _buildStatusChip(order.status),
        ],
      ),
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
            '${context.el.orderId}: ', _formatOrderNumber(order.orderId)),
        const VerticalSpace(height: 12),
        _buildInfoRow('${context.el.date}: ', _formatDate(order.date)),
        const VerticalSpace(height: 12),
        _buildInfoRow('${context.el.orderStatus}: ', order.status,
            isStatus: true),
        const VerticalSpace(height: 16),
        _buildDeliveryInfoSection(context),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStylesInter.font14BlackSemiBold,
        ),
        const HorizontalSpace(width: 8),
        if (isStatus)
          _buildStatusChip(value)
        else
          Expanded(
            child: Text(
              value,
              style: TextStylesInter.font14GreyRegular,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    final color = switch (status.toUpperCase()) {
      'NEW' => ColorsManager.mintGreen,
      'PENDING' => ColorsManager.orange,
      'CANCELLED' => ColorsManager.red,
      _ => ColorsManager.mainRose,
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 12.sp,
          fontWeight: FontWeightHelper.semiBold,
        ),
      ),
    );
  }

  Widget _buildDeliveryInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.el.deliveryInfo,
          style: TextStylesInter.font14BlackSemiBold,
        ),
        const VerticalSpace(height: 12),
        _buildDeliveryInfoItem(
            context.el.recipientName, order.deliveryInfo.name),
        _buildDeliveryInfoItem(context.el.phoneNumber,
            '${order.deliveryInfo.countryCode} ${order.deliveryInfo.phone}'),
        _buildDeliveryInfoItem(
            context.el.address,
            [
              order.deliveryInfo.shipping.recipientAddress,
              if (order.deliveryInfo.shipping.extraAddressDetails.isNotEmpty)
                order.deliveryInfo.shipping.extraAddressDetails,
            ].join('\n')),
        _buildDeliveryInfoItem(context.el.estimatedDeliveryTime,
            _formatDate(order.deliveryInfo.deliveryTime)),
        _buildDeliveryInfoItem(
            context.el.myIdentity,
            order.deliveryInfo.keepIdentitySecret
                ? context.el.hidden
                : context.el.visible),
        _buildDeliveryInfoItem(
            context.el.expressDelivery,
            order.deliveryInfo.expressDelivery
                ? context.el.yes
                : context.el.no),
      ],
    );
  }

  Widget _buildDeliveryInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(left: 16.r, bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStylesInter.font14GreyRegular,
          ),
          Text(
            value,
            style: TextStylesInter.font14BlackRegular,
          ),
        ],
      ),
    );
  }
}
