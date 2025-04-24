import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/routing/routes.dart';
import 'package:wardaya/features/home/data/apis/home_api_constants.dart';
import 'package:wardaya/features/home/data/models/home_gallery_response.dart';
import 'package:wardaya/features/home/logic/gallery/gallery_cubit.dart';
import 'package:wardaya/features/home/logic/gallery/gallery_state.dart';

import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/assets/assets.dart';
import '../../../../core/widgets/loading_widget.dart';

class GalleryBuilder extends StatelessWidget {
  const GalleryBuilder({super.key});

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
    return Skeletonizer(
      child: Container(
        color: ColorsManager.lightLighterGrey,
        height: context.pOH(60).h,
        child: Stack(
          children: [
            PageView.builder(
              controller: PageController(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: HomeApiConstants.apiBaseUrlForImages,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SvgPicture.asset(
                        Assets.of(context).svgs.small_logo_svg,
                        colorFilter: const ColorFilter.mode(
                          ColorsManager.lightGrey,
                          BlendMode.srcIn,
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: SvgPicture.asset(
                          Assets.of(context).svgs.small_logo_svg,
                          colorFilter: const ColorFilter.mode(
                            ColorsManager.lightGrey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 45.h,
                      left: 20.w,
                      right: 20.w,
                      child: SizedBox(
                        width: context.screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '',
                              style: TextStylesEBGaramond.font38WhiteBold,
                              softWrap: true,
                            ),
                            const VerticalSpace(height: 15),
                            Container(
                              width: 120.w,
                              decoration: BoxDecoration(
                                color: ColorsManager.white,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  '',
                                  style:
                                      TextStylesEBGaramond.font18MainRoseBold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: PageController(),
                  count: 1,
                  effect: const SlideEffect(
                    spacing: 8.0,
                    radius: 4.0,
                    dotWidth: 24.0,
                    dotHeight: 4.0,
                    dotColor: ColorsManager.grey,
                    activeDotColor: ColorsManager.mainRose,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _setupSuccess(
      BuildContext context, PageController controller, List<GalleryItem> data) {
    return SizedBox(
      height: context.pOH(60).h,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: HomeApiConstants.apiBaseUrlForImages +
                        data[index].imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SvgPicture.asset(
                      Assets.of(context).svgs.small_logo_svg,
                      colorFilter: const ColorFilter.mode(
                        ColorsManager.lightGrey,
                        BlendMode.srcIn,
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: SvgPicture.asset(
                        Assets.of(context).svgs.small_logo_svg,
                        colorFilter: const ColorFilter.mode(
                          ColorsManager.lightGrey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 45.h,
                    left: 20.w,
                    right: 20.w,
                    child: SizedBox(
                      width: context.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index].textOnImage,
                            style: TextStylesEBGaramond.font38WhiteBold,
                            softWrap: true,
                          ),
                          if ((data[index].recipient?.isNotEmpty ?? false) ||
                              (data[index].subCategory?.isNotEmpty ?? false) ||
                              (data[index].occasion?.isNotEmpty ?? false) ||
                              (data[index].brand?.isNotEmpty ?? false))
                            Column(
                              children: [
                                const VerticalSpace(height: 15),
                                Container(
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    color: ColorsManager.white,
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                  child: TextButton(
                                    onPressed: (data[index]
                                                    .recipient
                                                    ?.isNotEmpty ??
                                                false) ||
                                            (data[index]
                                                    .subCategory
                                                    ?.isNotEmpty ??
                                                false) ||
                                            (data[index].occasion?.isNotEmpty ??
                                                false) ||
                                            (data[index].brand?.isNotEmpty ??
                                                false)
                                        ? () {
                                            // Safe null checks with null-aware operators
                                            bool hasAnyValue = (data[index]
                                                        .recipient
                                                        ?.isNotEmpty ??
                                                    false) ||
                                                (data[index]
                                                        .subCategory
                                                        ?.isNotEmpty ??
                                                    false) ||
                                                (data[index]
                                                        .occasion
                                                        ?.isNotEmpty ??
                                                    false) ||
                                                (data[index]
                                                        .brand
                                                        ?.isNotEmpty ??
                                                    false);

                                            if (!hasAnyValue) {
                                              return; // Disable button if no values or all null
                                            }

                                            Map<String, dynamic> arguments = {};

                                            // Only add non-null and non-empty values
                                            if (data[index]
                                                    .recipient
                                                    ?.isNotEmpty ??
                                                false) {
                                              arguments['recipientId'] =
                                                  data[index].recipient;
                                            }
                                            if (data[index]
                                                    .subCategory
                                                    ?.isNotEmpty ??
                                                false) {
                                              arguments['subCategoryId'] =
                                                  data[index].subCategory;
                                            }
                                            if (data[index]
                                                    .occasion
                                                    ?.isNotEmpty ??
                                                false) {
                                              arguments['occasionId'] =
                                                  data[index].occasion;
                                            }
                                            if (data[index].brand?.isNotEmpty ??
                                                false) {
                                              arguments['brandId'] =
                                                  data[index].brand;
                                            }

                                            // Only add extraArgs if we have valid data
                                            if ((data[index]
                                                    .textOnImage
                                                    .isNotEmpty) &&
                                                hasAnyValue) {
                                              arguments['extraArgs'] =
                                                  data[index].textOnImage;
                                            }

                                            if (arguments.isNotEmpty) {
                                              context.pushNamed(
                                                Routes.categoryScreen,
                                                arguments: arguments,
                                              );
                                            }
                                          }
                                        : null,
                                    style: TextButton.styleFrom(
                                      disabledForegroundColor:
                                          ColorsManager.grey,
                                    ),
                                    child: Text(
                                      data[index].textOnButton,
                                      style: TextStylesEBGaramond
                                          .font18MainRoseBold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: data.length,
                effect: const SlideEffect(
                  spacing: 8.0,
                  radius: 4.0,
                  dotWidth: 24.0,
                  dotHeight: 4.0,
                  dotColor: ColorsManager.grey,
                  activeDotColor: ColorsManager.mainRose,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return BlocConsumer<GalleryCubit, GalleryState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
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
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
          },
          error: (error) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
              setupErrorState(context, error);
            });
          },
        );
      },
      builder: (context, state) {
        return state.when(
          loading: () => _setupLoading(context),
          success: (data) => _setupSuccess(context, pageController, data),
          error: (_) => const SizedBox.shrink(),
          initial: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
