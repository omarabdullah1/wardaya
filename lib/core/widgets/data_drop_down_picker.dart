// import 'dart:developer';

// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../helpers/extensions.dart';
// import '../theming/colors.dart';
// import '../theming/styles.dart';

// class DataDropdownPicker extends StatefulWidget {
//   final String hint;
//   final List<String> items;
//   final Function(String) onChanged;
//   final double? width;
//   final double? dropdownWidth;
//   final double? height;
//   final double? borderWidth;
//   final BorderRadius? borderRadius;
//   final Color? borderColor;

//   const DataDropdownPicker({
//     super.key,
//     required this.hint,
//     required this.items,
//     required this.onChanged,
//     this.width,
//     this.height,
//     this.dropdownWidth,
//     this.borderRadius,
//     this.borderColor,
//     this.borderWidth,
//   });

//   @override
//   State<DataDropdownPicker> createState() => _DataDropdownPickerState();
// }

// class _DataDropdownPickerState extends State<DataDropdownPicker> {
//   String? value;
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton2<String>(
//       isExpanded: true,
//       hint: Text(
//         widget.hint,
//         style: TextStyles.font14LightGrayMedium,
//         textAlign: TextAlign.center,
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//       ),
//       underline: const SizedBox(),
//       items: widget.items
//           .map((String item) => DropdownMenuItem<String>(
//                 value: item,
//                 child: Text(
//                   item,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//               ))
//           .toList(),
//       value: value,
//       onChanged: (String? cvalue) {
//         widget.onChanged(cvalue!);
//         setState(() {
//           value = cvalue;
//         });
//         log(value.toString());
//       },
//       buttonStyleData: ButtonStyleData(
//         height: widget.height ?? 55.0,
//         width: widget.width ?? (context.pOW(100.0).w - 20),
//         decoration: BoxDecoration(
//           color: ColorsManager.white,
//           borderRadius: widget.borderRadius ?? BorderRadius.circular(10.0.r),
//           border: Border.all(
//             color: widget.borderColor ?? ColorsManager.black.withAlpha(51),
//             width: widget.borderWidth ?? 0.5,
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       ),
//       iconStyleData: const IconStyleData(
//         icon: FaIcon(
//           FontAwesomeIcons.chevronDown,
//           size: 12,
//           color: ColorsManager.black,
//         ),
//       ),
//       dropdownStyleData: DropdownStyleData(
//         width: widget.dropdownWidth ?? (100.0.w - 20.w),
//         offset: const Offset(-0.0, -5.0),
//         useSafeArea: true,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(6.0),
//           color: ColorsManager.black.withAlpha(102),
//         ),
//       ),
//       style: TextStyles.font12BlackMedium,
//     );
//   }
// }
