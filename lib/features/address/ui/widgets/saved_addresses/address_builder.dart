import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/widgets/loading_widget.dart';

import '../../../../../core/routing/router_imports.dart';
import '../../../../../core/theming/colors.dart';
import '../../../data/models/address_response.dart';
import '../../../logic/address_cubit/address_cubit.dart';
import '../../../logic/address_cubit/address_state.dart';
import 'address_card.dart';

class AddressBuilder extends StatelessWidget {
  const AddressBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        return state.maybeMap(
          loading: (_) => _buildLoading(context),
          success: (successState) {
            final addresses = successState.addresses;
            if (addresses.isEmpty) {
              return _buildEmpty(
                  context); // Return the widget, don't call it as a function
            }

            return _buildSuccess(addresses, context);
          },
          error: (errorState) => _buildError(errorState.error, context),
          orElse: () => _buildEmpty(context),
        );
      },
    );
  }

  Widget _buildError(String error, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pop();
    });
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => context.read<AddressCubit>().getAddresses(),
            child: Text(context.el.tryAgain),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pop();
    });
    return Center(
      child: Text(
        context.el.addressesScreenNoAddressesFound,
        style: TextStyle(
          fontSize: 16.sp,
          color: ColorsManager.grey,
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingWidget(
          loadingState: true,
        ),
      );
    });
    return Skeletonizer(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return AddressCard(
            address: Address(
              id: '',
              userId: '',
              title: '',
              recipientArea: '',
              recipientAddress: '',
              extraAddressDetails: '',
              recipientPhoneNumber: '',
              recipientName: '',
              recipientCountryCode: '',
              latitude: 37.7749,
              longitude: -122.4194,
              version: 0,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuccess(List<Address> addresses, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pop();
    });
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final addressData = addresses[index];
        return AddressCard(
          address: addressData,
          onEditComplete: () => context.read<AddressCubit>().getAddresses(),
        );
      },
    );
  }
}
