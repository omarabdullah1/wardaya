import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/features/home/logic/occassions/occassions_cubit.dart';

import '../../../../../core/theming/styles.dart';
import '../../../../core/theming/colors.dart';
import '../../data/models/home_occassions_response.dart';
import '../../logic/occassions/occassions_state.dart';
import 'category_progress_scroll.dart';

class GiftsForEveryMomentBuilder extends StatelessWidget {
  const GiftsForEveryMomentBuilder({super.key});

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
    return const Skeletonizer(
      child: CategoryProgressScroll(
        categoriesImages: ['', '', '', '', '', '', '', '', '', ''],
        titles: ['', '', '', '', '', '', '', '', '', ''],
        isBackgroundColor: true,
      ),
    );
  }

  Widget _setupSuccess(BuildContext context, PageController controller,
      List<OccassionsItem> data) {
    List<String?> titles = data.map((item) => item.name).toList();
    List<String?> images = data.map((item) => item.imageUrl).toList();
    List<String> ids = data.map((item) => item.id).toList();

    return CategoryProgressScroll(
      categoriesImages: images.whereType<String>().toList(),
      titles: titles.whereType<String>().toList(),
      isBackgroundColor: true,
      ids: ids,
      sourceType: 'occasion',
    );
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocConsumer<OccassionsCubit, OccassionsState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          error: (error) {
            setupErrorState(context, error);
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => _setupLoading(context),
          success: (data) => _setupSuccess(context, pageController, data),
          error: (_) => const SizedBox.shrink(),
        );
      },
    );
  }
}
