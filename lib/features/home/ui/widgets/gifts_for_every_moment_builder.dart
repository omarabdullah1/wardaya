import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/features/home/logic/occassions/occassions_cubit.dart';

import '../../../../../core/theming/styles.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/loading_widget.dart';
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

  Widget _setupSuccess(BuildContext context, PageController controller,
      List<OccassionsItem> data) {
    List<String?> titles = data.map((item) => item.name).toList();
    List<String?> images = data.map((item) => item.imageUrl).toList();
    List<String> ids = data.map((item) => item.id).toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
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

    return BlocBuilder<OccassionsCubit, OccassionsState>(
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
