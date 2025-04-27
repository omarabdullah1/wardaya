import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import 'package:wardaya/features/address/logic/recipient_details_cubit/recipient_details_cubit.dart';
import 'package:wardaya/features/address/logic/recipient_details_cubit/recipient_details_state.dart';
import 'package:wardaya/features/address/ui/widgets/recipient_details/details_compact_map_preview.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/colors.dart';
import '../../../core/widgets/app_app_bar.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/widgets/loading_widget.dart';
import 'widgets/recipient_details/address_detail_field.dart';
import 'widgets/recipient_details/area_field.dart';
import 'widgets/recipient_details/recipient_name_phone_fields.dart';

class CreateRecipientDetailsScreen extends StatefulWidget {
  const CreateRecipientDetailsScreen({
    super.key,
  });

  @override
  State<CreateRecipientDetailsScreen> createState() =>
      _CreateRecipientDetailsScreenState();
}

class _CreateRecipientDetailsScreenState
    extends State<CreateRecipientDetailsScreen> {
  // Default location (Riyadh, Saudi Arabia)
  LatLng defaultLocation = const LatLng(24.7136, 46.6753);
  late RecipientDetailsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<RecipientDetailsCubit>();

    // Initialize with default location if no location is set
    cubit.selectedLocation ??= defaultLocation;
  }

  void onLocationChanged(LatLng location, String address, String area) {
    setState(() {
      cubit.selectedLocation = location;
      // Update location, address and area in cubit
      cubit.updateLocationData(location, address, area);

      // Also update the text fields directly
      cubit.addressController.text = address;
      cubit.areaController.text = area;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RecipientDetailsCubit>(),
      child: BlocConsumer<RecipientDetailsCubit, RecipientDetailsState>(
        listener: (context, state) {
          state.maybeWhen(
            loading: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const LoadingWidget(
                    loadingState: true,
                  ),
                );
              });
            },
            success: (address) {
              // Close loading dialog
              Navigator.pop(context);

              // Return true to indicate success and refresh the addresses list
              Navigator.pop(context, true);
            },
            error: (error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pop();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error)),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          cubit = context.read<RecipientDetailsCubit>();
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppAppBar(title: context.el.recipientDetailsScreenTitle),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0.w,
                  vertical: 16.0.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RecipientNamePhoneFields(
                      nameController: cubit.nameController,
                      phoneController: cubit.phoneController,
                      onCountryCodeChanged: (String countryCode) {
                        cubit.setCountryCode(countryCode);
                      },
                    ),
                    VerticalSpace(height: 24.h),
                    Text(
                      context.el.recipientDetailsScreenRecipientAreaLabel,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorsManager.black87,
                      ),
                    ),
                    VerticalSpace(height: 8.h),
                    DetailsCompactMapPreview(
                      location: cubit.selectedLocation ?? defaultLocation,
                      onLocationChanged: onLocationChanged,
                      height: 100.h,
                      showFullscreenButton: true,
                      address: cubit.addressController.text,
                      area: cubit.areaController.text,
                    ),
                    VerticalSpace(height: 16.h),
                    AreaField(
                      areaController: cubit.areaController,
                    ),
                    VerticalSpace(height: 16.h),
                    AddressDetailField(
                      label: context
                          .el.recipientDetailsScreenRecipientAddressLabel,
                      hint: context.el.addressLabelHint,
                      controller: cubit.addressController,
                    ),
                    VerticalSpace(height: 16.h),
                    AddressDetailField(
                      label: context
                          .el.recipientDetailsScreenRecipientExtraAddressLabel,
                      hint: context.el.extraAddressLabelHint,
                      controller: cubit.extraAddressController,
                    ),
                    VerticalSpace(height: 32.h),
                    state.maybeWhen(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      orElse: () => AppTextButton(
                        buttonText: context.el.saveButton,
                        textStyle: GoogleFonts.inter(
                          color: ColorsManager.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        onPressed: _saveAddress,
                      ),
                    ),
                    VerticalSpace(height: 16.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _saveAddress() async {
    // Validate address fields
    if (cubit.nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.el.fieldRequired)),
      );
      return;
    }

    if (cubit.phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.el.fieldRequired)),
      );
      return;
    }

    if (cubit.addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.el.fieldRequired)),
      );
      return;
    }

    if (cubit.selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.el.fieldRequired)),
      );
      return;
    }

    // Set city ID before creating address
    await cubit.setSelectedCityId();
    cubit.createAddress();
  }
}
