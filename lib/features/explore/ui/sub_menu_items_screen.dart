import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../data/models/menu_items_response.dart';

class SubMenuItemsScreen extends StatelessWidget {
  final BuildContext cartContext;
  final MenuItem menuItem;

  const SubMenuItemsScreen({
    super.key,
    required this.cartContext,
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.mainRose,
            size: 18.0.h,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          menuItem.name,
          style: GoogleFonts.ebGaramond(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w400,
            fontSize: 29.0.sp,
          ),
        ),

        backgroundColor:
            ColorsManager.transparent, // Make the AppBar transparent
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: menuItem.subMenuItems.isEmpty
            ? Center(
                child: Text(
                  context.el.subMenuItemsEmptyTitle,
                  style: GoogleFonts.inter(
                    color: ColorsManager.mainRose,
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0.sp,
                  ),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 12.0, // Spacing between columns
                  mainAxisSpacing: 12.0, // Spacing between rows
                  childAspectRatio: 0.7, // Aspect ratio of grid items (square)
                ),
                itemCount: menuItem.subMenuItems.length,
                itemBuilder: (context, index) {
                  log('Building sub menu item ${menuItem.subMenuItems[index].name}');
                  log('Building sub menu item ${menuItem.subMenuItems[index].id}');
                  return _buildSubMenuItem(
                      context, menuItem.subMenuItems[index]);
                },
              ),
      ),
    );
  }

  Widget _buildSubMenuItem(BuildContext context, SubMenuItem subMenuItem) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.categoryScreen,
          arguments: {
            'subMenuItemsId': subMenuItem.id,
            'extraArgs': subMenuItem.name,
          },
        );
      },
      child: Column(
        children: [
          Container(
            width: context.pOW(25).w,
            height: context.pOH(8.5).h,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0), // Background color of grid item
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
              image: DecorationImage(
                image: NetworkImage(
                    'https://wecareroot.ddns.net:5100${subMenuItem.imageUrl}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8.0.h), // Add spacing between image and text
          SizedBox(
            width: context.pOW(25).w,
            height: context.pOH(4).h,
            child: Text(
              subMenuItem.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: ColorsManager.mainRose,
                fontWeight: FontWeight.w400,
                fontSize: 12.0.sp,
              ),
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
