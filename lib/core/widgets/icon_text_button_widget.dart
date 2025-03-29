// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../helpers/extensions.dart';
// import '../helpers/spacing.dart';
// import '../theming/colors.dart';
// import '../theming/styles.dart';

// class IconTextButton extends StatelessWidget {
//   final bool isIcon;
//   final IconData? icon;
//   final String text;
//   final double? iconSize;
//   final double? widthPow;
//   final double? heightPoh;
//   final Color? color;
//   final Color? iconColor;
//   final Color? borderColor;
//   final TextStyle? textStyle;
//   final Function() onTap;
//   const IconTextButton({
//     super.key,
//     required this.isIcon,
//     this.icon,
//     required this.text,
//     this.iconSize,
//     this.widthPow,
//     this.heightPoh,
//     this.textStyle,
//     this.color,
//     this.iconColor,
//     this.borderColor,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onTap(),
//       child: Container(
//         width: widthPow != null ? context.pOW(widthPow ?? 20.0).w : null,
//         height: context.pOH(heightPoh ?? 3.0).h,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: borderColor ?? ColorsManager.mainBlue,
//             width: 2.0,
//           ),
//         ),
//         child: isIcon
//             ? Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       icon,
//                       size: iconSize ?? 20.0,
//                       color: iconColor??ColorsManager.mainBlue,
//                     ),
//                     HorizontalSpace(5.0),
//                     Text(
//                       text,
//                       style: textStyle ?? TextStyles.font12MainBlueBold,
//                     ),
//                   ],
//                 ),
//               )
//             : Center(
//                 child: Text(
//                   text,
//                   style: textStyle ?? TextStyles.font12MainBlueBold,
//                 ),
//               ),
//       ),
//     );
//   }
// }
