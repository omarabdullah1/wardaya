import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/features/home/data/apis/home_api_constants.dart';
import 'package:wardaya/features/home/data/models/home_gallery_response.dart';
import 'package:wardaya/features/home/logic/gallery/gallery_cubit.dart';
import 'package:wardaya/features/home/logic/gallery/gallery_state.dart';

import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../core/theming/colors.dart';

class GalleryBlocListener extends StatelessWidget {
  const GalleryBlocListener({super.key});

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
      child: SizedBox(
        height: context.pOH(50).h,
      ),
    );
  }

  Widget _setupSuccess(
      BuildContext context, PageController controller, GalleryResponse data) {
    return SizedBox(
      height: context.pOH(50).h,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: data.items.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    HomeApiConstants.apiBaseUrlForImages +
                        data.items[index].imageUrl,
                    fit: BoxFit.cover,
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
                            data.items[index].textOnImage,
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
                                data.items[index].textOnButton,
                                style: TextStylesEBGaramond.font18MainRoseBold,
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
                controller: controller,
                count: data.items.length,
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
          error: (error) {
            setupErrorState(context, error);
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
