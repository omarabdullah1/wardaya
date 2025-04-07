import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/routing/routes.dart';

import '../../../../core/assets/assets.dart';

class DiscoverIdeasSection extends StatelessWidget {
  const DiscoverIdeasSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.el.discoverNewIdeasTitle,
            style: GoogleFonts.ebGaramond(
              fontSize: 32.sp,
              fontWeight: FontWeight.w400,
              color: ColorsManager.mainRose,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300, // Adjust this based on your card height
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CardItem(
                    imageUrl: Assets.of(context).images.delivery_png,
                    title: context.el.discoverCardExpressDeliveryTitle,
                    buttonText: context.el.discoverCardExpressDeliveryButton,
                    onPressed: () {
                      // Navigate to category screen with express delivery parameter
                      context.pushNamed(
                        Routes.categoryScreen,
                        arguments: {
                          'extraArgs': 'Express Delivery',
                          'expressDelivery': true,
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  CardItem(
                    imageUrl: Assets.of(context).images.subscription_png,
                    title: context.el.discoverCardWeeklySurpriseTitle,
                    buttonText: context.el.discoverCardWeeklySurpriseButton,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String buttonText;
  final VoidCallback? onPressed;

  const CardItem(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.buttonText,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250, // Adjust width as needed
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Image.asset(
              imageUrl,
              colorBlendMode: BlendMode.srcATop,
              color: ColorsManager.black.withAlpha((0.26 * 255).toInt()),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        ColorsManager.black,
                        ColorsManager.transparent,
                      ],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.white,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: onPressed,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsManager.transparent,
                                side: const BorderSide(color: Colors.white)),
                            child: Text(
                              buttonText,
                              style: const TextStyle(
                                color: ColorsManager.white,
                              ),
                            )),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildShadedPlaceholder(BuildContext context) {
  //   return ShaderMask(
  //     shaderCallback: (Rect bounds) {
  //       return const LinearGradient(
  //         begin: Alignment.bottomCenter,
  //         end: Alignment.topCenter,
  //         colors: [
  //           Colors.black,
  //           Colors.black,
  //         ],
  //         stops: [0.0, 1.0],
  //       ).createShader(bounds);
  //     },
  //     blendMode: BlendMode.darken,
  //     child: Container(
  //       width: double.infinity,
  //       height: double.infinity,
  //       decoration: BoxDecoration(
  //         color: Colors.grey.withAlpha(51),
  //       ),
  //     ),
  //   );
  // }
}
