import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/font_weight_helper.dart';
import 'package:wardaya/core/widgets/app_app_bar.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/features/my_orders/logic/cubit/my_orders_cubit.dart';
import 'widgets/orders_list.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  Timer? _debounceTimer;

  void _onSearchChanged(String value) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      context.read<MyOrdersCubit>().getOrders(search: value);
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      appBar: AppAppBar(title: context.el.myOrders),
      body: SafeArea(
        child: RefreshIndicator(
          color: ColorsManager.mainRose,
          onRefresh: () async {
            context.read<MyOrdersCubit>().getOrders();
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: context.el.searchOrderPlaceholder,
                    hintStyle: TextStyle(
                      color: ColorsManager.lightGrey,
                      fontSize: 14.sp,
                      fontWeight: FontWeightHelper.semiBold,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: ColorsManager.mainRose,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: _onSearchChanged,
                ),
              ),
              const VerticalSpace(height: 8),
              const Expanded(
                child: OrdersListBuilder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
