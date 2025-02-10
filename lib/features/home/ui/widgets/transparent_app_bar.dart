import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/routing/routes.dart';

import '../../../../core/theming/styles.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TransparentAppBar({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(80); // Adjust height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: preferredSize.height,
      titleSpacing: 20,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.transparent, // Fully transparent background
          ),
        ),
      ),
      title: _buildAppBarContent(context),
    );
  }

  Widget _buildAppBarContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                context.el.appTitle,
                style: TextStylesKammer.font35WhiteRegular,
              ),
            ),
          ),
          _buildLocationButton(context),
          const SizedBox(width: 10),
          _buildSearchButton(context),
        ],
      ),
    );
  }

  Widget _buildLocationButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(45),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.el.deliveryTo,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w200,
              ),
            ),
            Row(
              children: [
                Text(
                  context.el.locationCity,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withAlpha(45),
      ),
      child: IconButton(
        icon: const Icon(Icons.search, color: Colors.white),
        onPressed: () {
          context.pushNamed(Routes.searchScreen);
        },
      ),
    );
  }
}
