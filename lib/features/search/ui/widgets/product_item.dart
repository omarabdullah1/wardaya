import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';

import '../../../../core/assets/assets.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final bool isGrid;
  final Function(Product) onTap;

  const ProductItem({
    super.key,
    required this.product,
    required this.isGrid,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(product),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.images.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: product.images.first,
                  height: isGrid ? 110.h : 200.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: ColorsManager.lightGrey,
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: isGrid ? 180.h : 200.h,
                    color: ColorsManager.transparent,
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.of(context).svgs.small_logo_svg,
                        height: isGrid ? 120.h : 150.h,
                        width: isGrid ? 120.w : 150.w,
                      ),
                    ),
                  ),
                ),
              )
            else
              Container(
                height: isGrid ? 110.h : 200.h,
                decoration: BoxDecoration(
                  color: ColorsManager.lightGrey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.of(context).svgs.small_logo_svg,
                    height: isGrid ? 120.h : 150.h,
                    width: isGrid ? 120.w : 150.w,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "SAR ",
                      style: GoogleFonts.inter(
                        fontSize: 11.0.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.mainRose,
                      ),
                      children: [
                        TextSpan(
                          text: product.price.total.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.mainRose,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    product.title,
                    style: GoogleFonts.inter(
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.mainRose,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
