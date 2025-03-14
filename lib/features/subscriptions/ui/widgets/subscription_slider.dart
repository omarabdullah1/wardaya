import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/theming/styles.dart';

class SubscriptionSlider extends StatefulWidget {
  const SubscriptionSlider(
      {super.key, required this.title, required this.images});
  final String title;
  final List<String> images;

  @override
  State<SubscriptionSlider> createState() => _SubscriptionSliderState();
}

class _SubscriptionSliderState extends State<SubscriptionSlider> {
  final PageController _controller = PageController();

  // List<String> _images(context) => [
  //       Assets.of(context).images.sub1_png,
  //       Assets.of(context).images.sub2_png,
  //       Assets.of(context).images.sub3_png,
  //     ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260.h,
      child: ClipRRect(
        // Added ClipRRect to clip the images
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Stack(
          children: [
            // Page View for Images
            PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              onPageChanged: (index) {},
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    widget.images[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),

            // Page Indicator positioned over the image
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        widget.title,
                        style: TextStylesEBGaramond.font30WhiteRegular,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: widget.images.length,
                        axisDirection: Axis.horizontal,
                        effect: SlideEffect(
                          spacing: 8.0,
                          radius: 4.0,
                          dotWidth: 24.0,
                          dotHeight: 4.0,
                          paintStyle: PaintingStyle.fill,
                          dotColor: ColorsManager.lightGrey
                              .withAlpha((0.5 * 255).toInt()),
                          activeDotColor: ColorsManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
