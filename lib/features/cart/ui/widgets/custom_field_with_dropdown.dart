import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';

class CustomTextFieldWithDropdown extends StatefulWidget {
  final String labelText;
  final List<String> dropdownItems;
  final BuildContext cartContext; // Consider removing this
  final TextEditingController textController;
  const CustomTextFieldWithDropdown({
    super.key,
    required this.labelText,
    required this.dropdownItems,
    required this.cartContext,
    required this.textController,
  });

  @override
  State<CustomTextFieldWithDropdown> createState() =>
      _CustomTextFieldWithDropdownState();
}

class _CustomTextFieldWithDropdownState
    extends State<CustomTextFieldWithDropdown> {
  String? _selectedValue;
  @override
  void initState() {
    super.initState();
    _selectedValue = widget.dropdownItems[
        widget.cartContext.read<CartCubit>().selectedTypingStyle];
    final cartCubit = BlocProvider.of<CartCubit>(widget.cartContext,
        listen: false); // NO LISTEN!
    widget.textController.text = cartCubit.fromController.text;
  }

  @override
  void dispose() {
    widget.textController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.labelText,
          style: GoogleFonts.inter(
            color: ColorsManager.lighterLightGrey,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: ColorsManager.lighterLightGrey),
              borderRadius: BorderRadius.circular(8),
              color: ColorsManager.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                          widget.textController, // Use the local controller
                      decoration: InputDecoration(
                        hintText: 'Optional',
                        hintStyle: _selectedValue == widget.dropdownItems.first
                            ? GoogleFonts.corinthia(
                                color: ColorsManager.lighterLightGrey,
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.bold,
                              )
                            : GoogleFonts.inter(
                                color: ColorsManager.lighterLightGrey,
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                        border: InputBorder.none,
                      ),
                      style: _selectedValue == widget.dropdownItems.first
                          ? GoogleFonts.corinthia(
                              color: ColorsManager.black,
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold,
                            )
                          : GoogleFonts.inter(
                              color: ColorsManager.black,
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                      onChanged: (value) {
                        final cartCubit = BlocProvider.of<CartCubit>(
                            widget.cartContext,
                            listen: false); // NO LISTEN!
                        cartCubit.setMessageData(
                          to: cartCubit.to,
                          message: cartCubit.message,
                          from: widget.textController
                              .text, // Get text from local controller
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: ColorsManager.lighterLightGrey,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: DropdownButton<String>(
                        value: _selectedValue,
                        items: widget.dropdownItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: item == 'Handwriting'
                                  ? GoogleFonts.corinthia(fontSize: 12.sp)
                                  : GoogleFonts.inter(fontSize: 12.sp),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              _selectedValue = newValue;
                              final cartCubit = BlocProvider.of<CartCubit>(
                                  widget.cartContext,
                                  listen: false);
                              cartCubit.setSelectingType(
                                widget.dropdownItems.indexOf(
                                    newValue ?? widget.dropdownItems.first),
                              );
                              log(cartCubit.selectedTypingStyle.toString());
                            },
                          );
                        },
                        icon: const Icon(Icons.keyboard_arrow_down),
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
