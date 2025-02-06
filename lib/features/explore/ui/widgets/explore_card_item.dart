import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';

class ExploreCardItem extends StatelessWidget {
  final String imageUrl;
  final String lable;
  final Function onTap;

  const ExploreCardItem({
    super.key,
    required this.imageUrl,
    required this.lable,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: 165.w,
        height: 180.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              CachedNetworkImage(
                colorBlendMode: BlendMode.srcATop,
                color: Colors.black26,
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                width: 165.w,
                height: 180.h,
                placeholder: (context, url) => _buildShadedPlaceholder(context),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                        ColorsManager.black87,
                        ColorsManager.transparent,
                      ],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: SizedBox(
                    height: 60.h,
                    child: Center(
                      child: Text(
                        lable,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShadedPlaceholder(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black,
            Colors.black,
          ],
          stops: [0.0, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.darken,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(51),
        ),
      ),
    );
  }
}
