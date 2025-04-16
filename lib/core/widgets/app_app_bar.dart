import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theming/colors.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backButtonColor;
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;
  const AppAppBar({
    super.key,
    required this.title,
    this.backButtonColor = ColorsManager.mainRose,
    this.showBackButton = true,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.ebGaramond(
          color: ColorsManager.mainRose,
          fontWeight: FontWeight.w400,
          fontSize: 37.0.sp,
        ),
      ),
      leading: showBackButton
          ? IconButton(
              onPressed: onBackButtonPressed ?? () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: backButtonColor,
              ),
            )
          : null,
      centerTitle: true,
      backgroundColor: Colors.transparent, // Make the AppBar transparent
      elevation: 0, // Remove AppBar shadow
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
