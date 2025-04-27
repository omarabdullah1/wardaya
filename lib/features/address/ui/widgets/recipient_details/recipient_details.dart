import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/address/ui/widgets/recipient_details/area_field.dart';

import '../../../../../core/routing/router_imports.dart';
import '../../../../../core/widgets/app_text_button.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../data/models/address_response.dart';
import '../../../logic/recipient_details_cubit/recipient_details_cubit.dart';
import '../../../logic/recipient_details_cubit/recipient_details_state.dart';
import 'address_detail_field.dart';
import 'recipient_map_widget.dart';
import 'recipient_name_phone_fields.dart';

class RecipientDetails extends StatelessWidget {
  final Address? address;
  const RecipientDetails({super.key, this.address});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RecipientDetailsCubit>();

    // Initialize with existing address if available
    if (address != null && cubit.nameController.text.isEmpty) {
      // Assuming address has these fields or they're null
      cubit.initializeWithAddress(
        address: address?.recipientAddress,
        area: address?.recipientArea,
        recipientName: address?.recipientName,
        phoneNumber: address?.recipientPhoneNumber,
        extraDetails: address?.extraAddressDetails,
        location: LatLng(address!.latitude, address!.longitude),
        id: address!.id, // Pass the address ID for editing
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecipientNamePhoneFields(
          nameController: cubit.nameController,
          phoneController: cubit.phoneController,
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
        RecipientMapWidget(
          address: address,
        ), // Using the correctly named widget
        VerticalSpace(height: 16.h),
        AreaField(
          areaController: cubit.areaController,
        ),
        VerticalSpace(height: 16.h),
        AddressDetailField(
          label: context.el.recipientDetailsScreenRecipientAddressLabel,
          hint: context.el.recipientDetailsScreenRecipientAddressLabel,
          controller: cubit.addressController,
        ),
        VerticalSpace(height: 16.h),
        AddressDetailField(
          label: context.el.recipientDetailsScreenRecipientExtraAddressLabel,
          hint: context.el.recipientDetailsScreenRecipientExtraAddressLabel,
          controller: cubit.extraAddressController,
        ),
        VerticalSpace(height: 32.h),
        BlocConsumer<RecipientDetailsCubit, RecipientDetailsState>(
          listener: (context, state) {
            state.maybeMap(
              loading: (_) {
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
              error: (state) {
                Navigator.pop(context, true); // Return with success result
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              },
              success: (state) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(address != null
                          ? context.el.addressUpdatedSuccessfully
                          : context.el.addressSavedSuccessfully)),
                );
                Navigator.pop(context, true); // Return with success result
                Navigator.pop(context, true); // Return with success result
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            final isLoading = state.maybeMap(
              loading: (_) => true,
              orElse: () => false,
            );

            final buttonText = address != null
                ? context.el.editProfileTitle
                : context.el.saveButton;

            return AppTextButton(
              buttonText: buttonText,
              textStyle: GoogleFonts.inter(
                color: ColorsManager.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              onPressed: isLoading ? () {} : () => _saveAddress(context, cubit),
            );
          },
        ),
        VerticalSpace(height: 16.h),
      ],
    );
  }

  void _saveAddress(BuildContext context, RecipientDetailsCubit cubit) async {
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

    // Set the city ID before saving
    await cubit.setSelectedCityId();

    // Save address (create or update based on addressId)
    await cubit.saveAddress();
  }
}
