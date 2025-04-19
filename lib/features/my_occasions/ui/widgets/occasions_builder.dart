import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/widgets/loading_widget.dart';
import 'package:wardaya/features/home/data/models/home_occassions_response.dart';
import 'package:wardaya/features/home/logic/occassions/occassions_cubit.dart';
import 'package:wardaya/features/home/logic/occassions/occassions_state.dart';
import 'package:wardaya/features/my_occasions/data/models/my_occasions_response.dart';

import 'occasion_card.dart';

class OccasionsBuilder extends StatelessWidget {
  final Function(MyOccasionItem)? onOccasionTap;

  const OccasionsBuilder({super.key, this.onOccasionTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OccassionsCubit, OccassionsState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => _buildLoading(context),
          success: (occasions) => _buildSuccess(context, occasions),
          error: (error) => _buildError(error, context),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    // Schedule the dialog to be shown after the current build phase completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingWidget(
          loadingState: true,
        ),
      );
    });

    // Return a skeleton loading UI
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 120.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: 4,
          itemBuilder: (context, index) => const OccasionCard(
            occasion: null,
            isLoading: true,
            // Remove the onTap parameter to match the success state
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<OccassionsItem> occasions) {
    // Dismiss any loading dialogs
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });

    if (occasions.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: const Text('No occasions available'),
        ),
      );
    }

    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: occasions.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            // Convert OccassionsItem to MyOccasionItem for the callback
            final myOccasion = MyOccasionItem(
              id: occasions[index].id,
              name: occasions[index].name ?? '',
              // Use DateTime.now() as a fallback if the OccassionsItem doesn't have a date property
              date: DateTime.now(),
              version: 1, // Default version
            );
            onOccasionTap?.call(myOccasion);
          },
          child: OccasionCard(
            occasion: occasions[index],
            isLoading: false,
            // Remove the redundant onTap parameter
          ),
        ),
      ),
    );
  }

  Widget _buildError(String error, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    });

    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Text('Error: $error'),
      ),
    );
  }
}
