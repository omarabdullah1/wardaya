import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/features/home/data/models/home_recipients_response.dart';

import '../../../../../core/theming/styles.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../logic/recipients/recipients_cubit.dart';
import '../../logic/recipients/recipients_state.dart';
import 'category_progress_scroll.dart';

class GiftsForEveryoneBuilder extends StatelessWidget {
  const GiftsForEveryoneBuilder({super.key});

  void setupErrorState(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          error,
          style: TextStyles.font22MainRoseSemiBold,
        ),
        backgroundColor: ColorsManager.red,
      ),
    );
  }

  Widget _setupLoading(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingWidget(
          loadingState: true,
        ),
      );
    });

    return const Skeletonizer(
      child: CategoryProgressScroll(
        categoriesImages: ['', '', '', '', '', '', '', '', '', ''],
        titles: ['', '', '', '', '', '', '', '', '', ''],
        isBackgroundColor: true,
      ),
    );
  }

  Widget _setupSuccess(
      BuildContext context, PageController controller, List<Recipient> data) {
    List<String?> titles = data.map((item) => item.name).toList();
    List<String?> ids = data.map((item) => item.id).toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });

    // Safely handling empty images lists
    List<String?> images = data.map((item) {
      if (item.images.isEmpty) {
        return null; // Return null for empty image lists
      }
      return item.images.first;
    }).toList();

    return CategoryProgressScroll(
      categoriesImages: images.whereType<String>().toList(),
      titles: titles.whereType<String>().toList(),
      isBackgroundColor: true,
      ids: ids.whereType<String>().toList(),
      sourceType: 'recipient',
    );
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocBuilder<RecipientsCubit, RecipientsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => _setupLoading(context),
          success: (data) => _setupSuccess(context, pageController, data),
          error: (_) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
