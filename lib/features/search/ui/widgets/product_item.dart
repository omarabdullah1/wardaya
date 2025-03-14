import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';

import '../../data/apis/search_api_constants.dart';

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
              Container(
                height: isGrid ? 120.h : 200.h,
                decoration: BoxDecoration(
                  color: ColorsManager.lightGrey,
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      SearchApiConstants.apiBaseUrlForImages +
                          product.images.first,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                height: isGrid ? 120.h : 200.h,
                decoration: BoxDecoration(
                  color: ColorsManager.lightGrey,
                  borderRadius: BorderRadius.circular(8.0),
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
