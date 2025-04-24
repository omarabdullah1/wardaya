import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/widgets/loading_widget.dart';
import 'package:wardaya/features/cart/logic/cubit/cart_cubit.dart';
import 'package:wardaya/features/cart/logic/uploadSignature/upload_signature_cubit.dart';
import 'package:wardaya/features/cart/logic/uploadSignature/upload_signature_state.dart';
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
      // Ensure we're using PNG format with proper image byte format
      final Uint8List data = await signature
          .toByteData(format: ui.ImageByteFormat.png)
          .then((byteData) => byteData!.buffer.asUint8List());

      // Use BlocProvider to get UploadSignatureCubit
      UploadSignatureCubit? uploadCubit;
      if (widget.cartContext.mounted) {
        uploadCubit = widget.cartContext.read<UploadSignatureCubit>();
      }
      if (uploadCubit == null) {
        throw Exception(
            'UploadSignatureCubit is not available in the context.');
      }
      // Show upload dialog with status management
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) =>
              BlocConsumer<UploadSignatureCubit, UploadSignatureState>(
            bloc: uploadCubit,
            listener: (context, state) {
              state.maybeWhen(
                loaded: (response) {
                  // Set signature link in CartCubit on success
                  widget.cartContext.read<CartCubit>().setSignatureLink(
                        signatureLink: response.imageUrl,
                      );

                  // Close the dialog and bottom sheet
                  Navigator.of(dialogContext).pop();

                  // Save signature data and close
                  if (mounted) {
                    widget.onSave(data);
                    context.pop();
                  }
                },
                error: (message) {
                  // Close the loading dialog
                  Navigator.of(dialogContext).pop();

                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        message,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                orElse: () {},
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const LoadingWidget(loadingState: true),
                orElse: () => const LoadingWidget(loadingState: true),
              );
            },
          ),
        );
      }
      // Always use a timestamp in filename to avoid caching issues and ensure .png extension
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filename = 'signature_$timestamp.png';

      // Start the upload process with explicit PNG filename
      await uploadCubit.uploadSignature(data, fileName: filename);
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
              context.el.signatureTitle,
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
                    context.el.clearButton,
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
                    context.el.saveButton,
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
                              context.el.drawInstruction,
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
                              color: ColorsManager.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: ColorsManager.grey,
                              ),
                            ),
                            child: Signature(
                              key: _signatureKey,
                              color: ColorsManager.black,
                              strokeWidth: 3.0,
                              backgroundPainter: null,
                            ),
                          ),
                        ],
                      )
                    : CustomTextFieldWithDropdown(
                        labelText: context.el.fromLabel,
                        dropdownItems: [
                          context.el.handwrittenStyle,
                          context.el.typedStyle
                        ],
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
