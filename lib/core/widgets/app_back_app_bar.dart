import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/styles.dart';

import '../theming/colors.dart';

class AppBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final Color iconColor;
  final IconData iconData;
  final String title;
  final double elevation;
  final Function()? onBack;
  const AppBackAppBar({
    super.key,
    required this.title,
    required this.onBack,
    this.backgroundColor = ColorsManager.white,
    this.iconColor = ColorsManager.mainRose,
    this.iconData = Icons.arrow_back_ios,
    this.elevation = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: IconButton(
        icon: Icon(
          iconData,
          color: iconColor,
          size: 18.0.h,
        ),
        onPressed: onBack ??
            () {
              context.pop();
            },
      ),
      title: Text(
        title,
        style: TextStylesInter.font17MainRoseBold,
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
