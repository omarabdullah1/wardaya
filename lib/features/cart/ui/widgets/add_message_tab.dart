import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/features/cart/ui/widgets/previewer.dart';

import '../../logic/cubit/cart_cubit.dart';
import 'past_link_buttom_sheet.dart';
import 'signature_bottom_sheet.dart';
import 'suggested_messages_bottom_sheet.dart'; // Import

class AddMessageTab extends StatefulWidget {
  final bool isSignatureSelected;
  final VoidCallback onSignatureToggle;
  final BuildContext cartContext;

  const AddMessageTab({
    super.key,
    required this.isSignatureSelected,
    required this.onSignatureToggle,
    required this.cartContext,
  });

  @override
  State<AddMessageTab> createState() => _AddMessageTabState();
}

class _AddMessageTabState extends State<AddMessageTab> {
  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    final signatureImage = cartCubit.signature; // Get saved signature

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 16.0.h),
        child: Container(
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/small_logo.svg',
                      height: 35.h,
                    ),
                    SizedBox(height: 5.h),
                    _buildTextFieldRow(
                      context,
                      label: 'To:',
                      controller: cartCubit.toController,
                      hint: 'Optional',
                      widthFactor: 0.60,
                    ),
                    SizedBox(height: 16.h),
                    _buildMessageField(context),
                    SizedBox(height: 16.h),
                    Text.rich(
                      TextSpan(
                        text: 'Not sure what to say? ',
                        style: GoogleFonts.inter(
                          color: ColorsManager.lighterLightGrey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: 'Try Suggested Messages',
                            style: GoogleFonts.inter(
                              color: ColorsManager.mainRose,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Show the suggested messages bottom sheet
                                _showSuggestedMessagesBottomSheet(context);
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // If signature is available, show the image instead of the "From" field
                    if (signatureImage != null)
                      Container(
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorsManager.lighterLightGrey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'From:',
                                style: GoogleFonts.inter(
                                  color: ColorsManager.lighterLightGrey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Image.memory(signatureImage, fit: BoxFit.contain),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<CartCubit>()
                                      .setSignature(signature: null);
                                },
                                child: SvgPicture.asset(
                                  'assets/svgs/remove.svg',
                                  colorFilter: const ColorFilter.mode(
                                    ColorsManager.lightGrey,
                                    BlendMode.srcIn,
                                  ),
                                  height: 15.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      _buildTextFieldRow(
                        context,
                        label: 'From:',
                        controller: cartCubit.fromController,
                        hint: 'Optional',
                        widthFactor: 0.40,
                        trailing: InkWell(
                          onTap: () => _showSignatureBottomSheet(context),
                          child: InkWell(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/signature.svg',
                                  height: 15.h,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  'Signature',
                                  style: GoogleFonts.inter(
                                    color: ColorsManager.mainRose,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                    SizedBox(height: 16.h),
                  ],
                ),
              ),
              const Divider(color: ColorsManager.lighterLightGrey),
              !context.read<CartCubit>().linkController.text.isNullOrEmpty()
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Container(
                            width: 80.w,
                            height: 65.h,
                            decoration: BoxDecoration(
                              color: ColorsManager.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: LinkPreviewGenerator(
                              url:
                                  context.read<CartCubit>().linkController.text,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              width: context.screenWidth*0.4.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    context.read<CartCubit>().linkController.text,
                                    style: GoogleFonts.inter(
                                      color: ColorsManager.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Added as a QR Code',
                                    style: GoogleFonts.inter(
                                      color: ColorsManager.lightGrey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                            child: InkWell(
                              onTap: () {
                                context.read<CartCubit>().setLink(link: '');
                              },
                              child: SvgPicture.asset(
                                'assets/svgs/remove.svg',
                                colorFilter: const ColorFilter.mode(
                                  ColorsManager.lightGrey,
                                  BlendMode.srcIn,
                                ),
                                height: 20.0.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled:
                                    true, // Allows the bottom sheet to take up more of the screen if needed
                                builder: (_) {
                                  return SizedBox(
                                    height: 450.h,
                                    child: PasteLinkBottomSheet(
                                      cartContext: widget.cartContext,
                                      initialTabIndex: 0,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/video.svg',
                                  height: 15.h,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'Record Video',
                                  style: GoogleFonts.inter(
                                    color: ColorsManager.mainRose,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'OR',
                            style: GoogleFonts.inter(
                              color: ColorsManager.lighterLightGrey,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled:
                                    true, // Allows the bottom sheet to take up more of the screen if needed
                                builder: (_) {
                                  return SizedBox(
                                    height: 450.h,
                                    child: PasteLinkBottomSheet(
                                      cartContext: widget.cartContext,
                                      initialTabIndex: 1,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/link.svg',
                                  height: 15.h,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'Paste a Link',
                                  style: GoogleFonts.inter(
                                    color: ColorsManager.mainRose,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldRow(BuildContext context,
      {required String label,
      required TextEditingController controller,
      required String hint,
      required double widthFactor,
      Widget? trailing}) {
    List<String> styles = ['Handwritten', 'Typed'];
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: ColorsManager.lighterLightGrey),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  color: ColorsManager.lighterLightGrey,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 4.0),
                child: SizedBox(
                  width: (context.screenWidth * widthFactor).w,
                  child: TextField(
                    controller: controller,
                    maxLength: 32,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: label == 'From:'
                          ? GoogleFonts.corinthia(
                              color: ColorsManager.grey,
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold,
                            )
                          : GoogleFonts.inter(
                              color: ColorsManager.grey,
                              fontSize: 14.0.sp,
                            ),
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      context.read<CartCubit>().setMessageData(
                            to: label == 'From:'
                                ? context.read<CartCubit>().toController.text
                                : value,
                            message: context
                                .read<CartCubit>()
                                .messageController
                                .text,
                            from: label == 'From:'
                                ? value
                                : context.read<CartCubit>().fromController.text,
                          );
                    },
                    style: (label == 'From:' &&
                            styles[context
                                    .read<CartCubit>()
                                    .selectedTypingStyle] ==
                                'Handwritten')
                        ? GoogleFonts.corinthia(
                            color: ColorsManager.black,
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                          )
                        : GoogleFonts.inter(
                            color: ColorsManager.black,
                            fontSize: 14.0.sp,
                          ),
                  ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageField(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140.h,
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: ColorsManager.lighterLightGrey),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            width: (context.screenWidth * 0.7).w,
            height: 110.0.h,
            child: TextField(
              controller: context.watch<CartCubit>().messageController,
              maxLines: 4,
              maxLength: 192,
              decoration: InputDecoration(
                hintText: 'Type your message and express your feelings',
                hintStyle: GoogleFonts.inter(
                  color: ColorsManager.lighterLightGrey,
                  fontSize: 14.sp,
                ),
                hintMaxLines: 2,
                counterText: '',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                context.read<CartCubit>().setMessageData(
                      to: context.read<CartCubit>().toController.text,
                      message: value,
                      from: context.read<CartCubit>().fromController.text,
                    );
              },
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: context.watch<CartCubit>().messageController,
              builder: (context, value, child) {
                return Text(
                  '${192 - value.text.length} Characters left',
                  style: GoogleFonts.inter(
                    color: ColorsManager.lighterLightGrey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSignatureBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SignatureBottomSheet(
        onSave: (Uint8List signature) {
          context
              .read<CartCubit>()
              .setSignature(signature: signature); // Save to Cubit
        },
        cartContext: widget.cartContext,
      ),
    );
  }

  void _showSuggestedMessagesBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => SizedBox(
        height: 450.h,
        child: SuggestedMessagesBottomSheet(
          onMessageSelected: (String message) {
final cubit=context.read<CartCubit>();
           cubit .setMessageData(
            to: cubit.to,
            message: message,
            from: cubit.from,
           );
          },
        ),
      ),
    );
  }
}
