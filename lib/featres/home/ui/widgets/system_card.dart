import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets/assets.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class SystemCard extends StatelessWidget {
  final String image;
  final String systemTitle;
  final String systemDescription;
  final VoidCallback onTap;
  final bool? isBot;

  const SystemCard({
    super.key,
    required this.image,
    required this.systemTitle,
    required this.systemDescription,
    required this.onTap,
    this.isBot,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: isBot == null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Stack(
                children: [
                  Container(
                    height: 90.0.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Semi-transparent color overlay
                  Container(
                    height: 90.0.h,
                    width: double.infinity,
                    color: ColorsManager.black.withAlpha(127),
                  ),
                  // Content goes on top
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            systemTitle,
                            style: TextStyles.font20WhiteBold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            systemDescription,
                            style: TextStyles.font12WhiteMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              height: 90.0.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManager.lightBlue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            systemTitle,
                            style: TextStyles.font20WhiteBold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            systemDescription,
                            style: TextStyles.font12WhiteMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 15.0,
                    bottom: -10.0,
                    child: Image(
                      image: const AssetImage(
                        Assets.chatBot,
                      ),
                      height: 90.0.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
