import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/features/home/data/apis/home_api_constants.dart';
import 'package:wardaya/features/home/logic/brands/brands_cubit.dart';

import '../../../../../core/theming/styles.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../logic/brands/brands_state.dart';

class BrandsYoullLoveBuilder extends StatelessWidget {
  const BrandsYoullLoveBuilder({super.key});

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
      child: BrandsGrid(
        brandImages: ['', '', '', '', '', ''],
        brandNames: ['', '', '', '', '', ''],
        brandIds: ['', '', '', '', '', ''],
      ),
    );
  }

  Widget _setupSuccess(
      BuildContext context,
      PageController controller,
      List<String> brandsCategoriesImages,
      List<String> brandsTitles,
      List<String> brandIds) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
    return BrandsGrid(
      brandImages: brandsCategoriesImages,
      brandNames: brandsTitles,
      brandIds: brandIds,
    );
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocBuilder<BrandsCubit, BrandsState>(
      builder: (context, state) {
        return state.when(
          loading: () => _setupLoading(context),
          success: (data) => _setupSuccess(
            context,
            pageController,
            data.brands
                .map((e) => e.coverImageUrl)
                .whereType<String>()
                .toList(),
            data.brands.map((e) => e.name).whereType<String>().toList(),
            data.brands.map((e) => e.id).whereType<String>().toList(),
          ),
          error: (_) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
            return const SizedBox.shrink();
          },
          initial: () => const SizedBox.shrink(),
        );
      },
    );
  }
}

// Custom widget specifically for brands display
class BrandsGrid extends StatelessWidget {
  final List<String> brandImages;
  final List<String> brandNames;
  final List<String> brandIds;
  final double _initialThreshold = 0.2; // 20% threshold

  const BrandsGrid({
    super.key,
    required this.brandImages,
    required this.brandNames,
    required this.brandIds,
  });

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final ValueNotifier<double> scrollProgress =
        ValueNotifier<double>(_initialThreshold);

    // Update progress when scrolling
    scrollController.addListener(() {
      if (scrollController.hasClients &&
          scrollController.position.maxScrollExtent > 0) {
        // Calculate the actual scroll progress
        double actualProgress =
            scrollController.offset / scrollController.position.maxScrollExtent;

        // Map the actual progress (0.0 to 1.0) to a range from initialThreshold to 1.0
        double mappedProgress =
            _initialThreshold + (actualProgress * (1.0 - _initialThreshold));

        // Ensure progress is never below the threshold
        scrollProgress.value = mappedProgress.clamp(_initialThreshold, 1.0);
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 220.h, // Reduced height to fit progress bar
          child: GridView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.w,
              crossAxisSpacing: 12.h,
              childAspectRatio: 1.0,
            ),
            itemCount: brandImages.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildBrandItem(
                context: context,
                imagePath: brandImages[index],
                title: brandNames[index],
                brandId: brandIds[index],
                index: index,
              );
            },
          ),
        ),
        SizedBox(height: 16.h),
        // Progress indicator with threshold
        ValueListenableBuilder<double>(
          valueListenable: scrollProgress,
          builder: (context, value, child) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Stack(
                children: [
                  // Background track
                  Container(
                    height: 2.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.lightGrey,
                      borderRadius: BorderRadius.circular(1.h),
                    ),
                  ),
                  // Progress indicator with minimum threshold
                  FractionallySizedBox(
                    widthFactor: value,
                    child: Container(
                      height: 2.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.mainRose,
                        borderRadius: BorderRadius.circular(1.h),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBrandItem({
    required BuildContext context,
    required String imagePath,
    required String title,
    required String brandId,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to brand page or category
        context.pushNamed(
          Routes.categoryScreen,
          arguments: {
            'extraArgs': title,
            'brandId': brandId,
          },
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: imagePath.isNullOrEmpty()
                  ? BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: ColorsManager.mainRose.withAlpha(30),
                      borderRadius: BorderRadius.circular(12.5),
                    )
                  : null,
              child: imagePath.isNullOrEmpty()
                  ? null
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12.5),
                      child: CachedNetworkImage(
                        imageUrl:
                            HomeApiConstants.apiBaseUrlForImages + imagePath,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            color: ColorsManager.mainRose.withAlpha(30),
                            borderRadius: BorderRadius.circular(12.5),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.of(context).svgs.small_logo_svg,
                              colorFilter: const ColorFilter.mode(
                                ColorsManager.mainRose,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            color: ColorsManager.mainRose.withAlpha(30),
                            borderRadius: BorderRadius.circular(12.5),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: ColorsManager.mainRose,
                              strokeWidth: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 5),
          if (!title.isNullOrEmpty())
            Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: ColorsManager.mainRose,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
    );
  }
}
