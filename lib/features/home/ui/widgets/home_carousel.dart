import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';

import '../../../../core/assets/assets.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final PageController _controller = PageController();

  List<String> _images(context) => [
        Assets.of(context).images.flowers_png,
        Assets.of(context).images.flowers_png,
        Assets.of(context).images.flowers_png,
        Assets.of(context).images.flowers_png,
      ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.pOH(50).h,
      child: Stack(
        children: [
          // Page View for Images
          PageView.builder(
            controller: _controller,
            itemCount: _images(context).length,
            onPageChanged: (index) {},
            itemBuilder: (context, index) {
              return Image.asset(
                Assets.of(context).images.flowers_png,
                fit: BoxFit.cover,
              );
            },
          ),

          // Page Indicator positioned over the image
          Positioned(
            bottom: 20, // Adjust position as needed
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: _images(context).length,
                axisDirection: Axis.horizontal,
                effect: const SlideEffect(
                  spacing: 8.0,
                  radius: 4.0,
                  dotWidth: 24.0,
                  dotHeight: 4.0,
                  paintStyle: PaintingStyle.fill,
                  dotColor: Colors.grey,
                  activeDotColor: ColorsManager.mainRose,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
