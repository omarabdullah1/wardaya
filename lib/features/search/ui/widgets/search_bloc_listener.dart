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

class SearchBlocListener extends StatefulWidget {
  const SearchBlocListener({super.key});

  @override
  State<SearchBlocListener> createState() => _SearchBlocListenerState();
}

class _SearchBlocListenerState extends State<SearchBlocListener> {
  // Track if there's a loading dialog showing
  bool isLoadingDialogShowing = false;

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
      listenWhen: (previous, current) {
        // Add check to ignore Success states during pagination
        if (current is Success && previous is Success) {
          // This is probably a pagination update, don't trigger dialog actions
          return false;
        }
        return current is Loading ||
            current is Success ||
            current is Error ||
            current is LoadingFilterData ||
            current is SuccessFilterData ||
            current is ErrorFilterData;
      },
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            if (!isLoadingDialogShowing) {
              setState(() {
                isLoadingDialogShowing = true;
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) => const LoadingWidget(
                    loadingState: true,
                  ),
                ).then((_) {
                  if (mounted) {
                    setState(() {
                      isLoadingDialogShowing = false;
                    });
                  }
                });
              });
            }
          },
          success: (_) {
            // Only pop if we previously showed a loading dialog
            if (isLoadingDialogShowing) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // Check if we can pop before trying to pop
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                  if (mounted) {
                    setState(() {
                      isLoadingDialogShowing = false;
                    });
                  }
                }
              });
            }
          },
          error: (error) {
            setupErrorState(context, error);
          },
          loadingFilterData: () {
            if (!isLoadingDialogShowing) {
              setState(() {
                isLoadingDialogShowing = true;
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) => const LoadingWidget(
                    loadingState: true,
                  ),
                ).then((_) {
                  if (mounted) {
                    setState(() {
                      isLoadingDialogShowing = false;
                    });
                  }
                });
              });
            }
          },
          errorFilterData: (error) {
            setupErrorState(context, error);
          },
          successFilterData: (response) {
            if (isLoadingDialogShowing) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                  if (mounted) {
                    setState(() {
                      isLoadingDialogShowing = false;
                    });
                  }
                }
                _setupShowFilterBottomSheet(context, response);
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _setupShowFilterBottomSheet(context, response);
              });
            }
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
