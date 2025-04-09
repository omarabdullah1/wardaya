import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/explore/data/apis/explore_api_constants.dart';

class CategoryButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorsManager.mainRose.withAlpha(25),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
            vertical: 10.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.mainRose,
                ),
              ),
              SizedBox(
                height: 60.h,
                width: 60.h,
                child: CachedNetworkImage(
                  imageUrl: ExploreApiConstants.apiBaseUrlForImages + imagePath,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Skeletonizer(
                    child: SizedBox(
                      height: 60.h,
                      width: 60.h,
                    ),
                  ),
                  errorWidget: (context, url, error) => Center(
                    child: SvgPicture.asset(
                      Assets.of(context).svgs.small_logo_svg,
                      colorFilter: const ColorFilter.mode(
                        ColorsManager.mainRose,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
