import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/features/address/ui/widgets/recipient_details/new_address_button.dart';

import '../../../core/theming/colors.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../logic/address_cubit/address_cubit.dart';
import 'widgets/saved_addresses/address_builder.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Refresh the addresses list
        context.read<AddressCubit>().getAddresses();
      },
      child: Scaffold(
        backgroundColor: ColorsManager.offWhite,
        appBar: AppAppBar(title: context.el.addressesScreenTitle),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
            child: const Column(
              children: [
                // Add new address button
                NewAddressButton(),
                VerticalSpace(height: 16),

                // List of addresses
                AddressBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
