import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../core/theming/colors.dart';
import '../../data/models/filter_data_response.dart';
import '../../logic/cubit/search_cubit.dart';
import '../../logic/cubit/search_state.dart';
import 'filter_bottom_sheet.dart';

class SearchBlocListener extends StatelessWidget {
  const SearchBlocListener({super.key});

  void setupErrorState(BuildContext context, String error) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(
            Icons.error,
            color: ColorsManager.red,
            size: 32,
          ),
          content: Text(
            error,
            style: TextStyles.font22MainRoseSemiBold,
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                'Got it',
                style: TextStyles.font22MainRoseSemiBold,
              ),
            ),
          ],
        ),
      );
    });
  }

  void _setupShowFilterBottomSheet(
      BuildContext context, FilterDataResponse response) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => BlocProvider.value(
          value: context.read<SearchCubit>(),
          child: FilterBottomSheet(
            filterDataResponse: response,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchCubit, SearchState>(
      listenWhen: (previous, current) =>
          current is Loading ||
          current is Success ||
          current is Error ||
          current is LoadingFilterData ||
          current is SuccessFilterData ||
          current is ErrorFilterData,
      listener: (context, state) {
        state.whenOrNull(
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
          success: (_) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
            });
          },
          error: (error) {
            setupErrorState(context, error);
          },
          loadingFilterData: () {
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
          errorFilterData: (error) {
            setupErrorState(context, error);
          },
          successFilterData: (response) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pop();
              _setupShowFilterBottomSheet(context, response);
            });
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
