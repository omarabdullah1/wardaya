import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';
import 'package:wardaya/features/cart/ui/widgets/signature_text_selector.dart';

import 'custom_field_with_dropdown.dart';

class SignatureBottomSheet extends StatefulWidget {
  final Function(Uint8List) onSave;
  final BuildContext cartContext;

  const SignatureBottomSheet(
      {super.key, required this.onSave, required this.cartContext});

  @override
  State<SignatureBottomSheet> createState() => _SignatureBottomSheetState();
}

class _SignatureBottomSheetState extends State<SignatureBottomSheet> {
  final GlobalKey<SignatureState> _signatureKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  void _clearSignatureText() {
    _signatureKey.currentState?.clear();
    setState(() {
      _textController.clear();
      widget.cartContext.read<CartCubit>().setMessageData(
            to: widget.cartContext.read<CartCubit>().toController.text,
            message:
                widget.cartContext.read<CartCubit>().messageController.text,
            from: '',
          );
      context.pop();
    });
  }

  Future<void> _saveSignatureText() async {
    setState(() {
      widget.cartContext.read<CartCubit>().setMessageData(
            to: widget.cartContext.read<CartCubit>().toController.text,
            message:
                widget.cartContext.read<CartCubit>().messageController.text,
            from: _textController.text,
          );
      context.pop();
    });
  }

  Future<void> _saveSignatureHandWritten() async {
    final signature = await _signatureKey.currentState?.getData();
    if (signature != null) {
      final Uint8List data = await signature
          .toByteData(format: ui.ImageByteFormat.png)
          .then((byteData) => byteData!.buffer.asUint8List());
      widget.onSave(data);
    }
    if (mounted) {
      context.pop();
    }
  }

  //clear signature Handwritten
  Future<void> _clearSignatureHandWritten() async {
    _signatureKey.currentState?.clear();
    // context.pop();
  }

  int _selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 450.0.h,
        padding: const EdgeInsets.all(16),
        child: Scaffold(
          backgroundColor: ColorsManager.white,
          appBar: AppBar(
            backgroundColor: ColorsManager.white,
            title: Text(
              'Your Signature',
              style: GoogleFonts.inter(
                color: ColorsManager.mainRose,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: ColorsManager.mainRose,
              onPressed: () => Navigator.pop(context),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => _selectedTabIndex == 0
                      ? _clearSignatureHandWritten()
                      : _clearSignatureText(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: ColorsManager.mainRose,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: const TextStyle(fontSize: 16),
                    minimumSize: Size(150.w, 0.h),
                  ),
                  child: Text(
                    "Clear",
                    style: GoogleFonts.inter(
                      color: ColorsManager.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectedTabIndex == 0
                      ? _saveSignatureHandWritten()
                      : _saveSignatureText(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: ColorsManager.mainRose,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: const TextStyle(fontSize: 16),
                    minimumSize: Size(150.w, 0.h),
                  ),
                  child: Text(
                    "Save",
                    style: GoogleFonts.inter(
                      color: ColorsManager.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                  child: SignatureTextSelector(
                    selectedIndex: _selectedTabIndex,
                    onTabSelected: (index) {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                      // Handle tab selection logic here (e.g., show different content)
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0.h,
                ),
                _selectedTabIndex == 0
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0.h),
                            child: Text(
                              'Draw Your Signature iside the frame',
                              style: GoogleFonts.inter(
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.w300,
                                color: ColorsManager.black,
                              ),
                            ),
                          ),
                          Container(
                            height: 200.0.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: ColorsManager.grey,
                              ),
                            ),
                            child: Signature(
                              key: _signatureKey,
                              color: Colors.black,
                              strokeWidth: 3.0,
                              backgroundPainter: null,
                            ),
                          ),
                        ],
                      )
                    : CustomTextFieldWithDropdown(
                        labelText: 'From:',
                        dropdownItems: const ['Handwriting', 'Text'],
                        cartContext: widget.cartContext,
                        textController: _textController,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
