import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localization/localization.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/styles.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/features/my_orders/logic/cubit/my_orders_cubit.dart';
import 'package:wardaya/features/my_orders/logic/cubit/my_orders_state.dart';
import '../../data/models/my_orders_response.dart';
import 'order_card.dart';

class OrdersListBuilder extends StatelessWidget {
  const OrdersListBuilder({super.key});

  Order _getDummyOrder() => Order(
        id: 'loading',
        orderId: 'loading',
        userId: 'loading',
        email: 'loading@example.com',
        status: 'Loading...',
        deliveryAreaCity: 'Loading...',
        deliveryInfo: DeliveryInfo(
          name: 'Loading...',
          phone: 'Loading...',
          countryCode: '+00',
          shipping: ShippingInfo(
            id: 'loading',
            userId: 'loading',
            recipientArea: 'Loading...',
            recipientAddress: 'Loading...',
            extraAddressDetails: '',
            latitude: 0,
            longitude: 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          deliveryTime: DateTime.now(),
          keepIdentitySecret: false,
          expressDelivery: false,
        ),
        products: [],
        subtotal: 0,
        deliveryCharges: 0,
        total: 0,
        vatPercentage: 0,
        paymentMethod: 'Loading...',
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        customStatusSort: 0,
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOrdersCubit, MyOrdersState>(
      builder: (context, state) {
        return state.when(
          initial: _buildInitial,
          loading: _buildLoading,
          error: _buildError,
          success: (response) => _buildSuccess(response, context),
        );
      },
    );
  }

  Widget _buildInitial() => const SizedBox.shrink();

  Widget _buildLoading() => Skeletonizer(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          itemCount: 3, // Show 3 skeleton items while loading
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: OrderCard(
                order: _getDummyOrder(),
              ),
            );
          },
        ),
      );

  Widget _buildError(String message) => Center(
        child: Text(
          message,
          style: TextStyle(
            color: ColorsManager.mainRose,
            fontSize: 16.sp,
          ),
        ),
      );

  Widget _buildSuccess(MyOrdersResponse orders, BuildContext context) {
    final cubit = context.read<MyOrdersCubit>();

    if (orders.orders.isEmpty) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.of(context).svgs.empty_orders_svg,
                    height: 200.h,
                    width: 200.w,
                  ),
                  const VerticalSpace(height: 16),
                  Text(
                    context.el.noOrders,
                    style: TextStylesInter.font14GreyRegular,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent &&
            !cubit.isLoadingMore &&
            cubit.hasMorePages) {
          cubit.loadMoreOrders();
        }
        return false;
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        itemCount: orders.orders.length + (cubit.hasMorePages ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= orders.orders.length) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: const CircularProgressIndicator(),
              ),
            );
          }

          final order = orders.orders[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: OrderCard(order: order),
          );
        },
      ),
    );
  }
}
