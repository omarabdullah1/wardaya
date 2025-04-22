import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../logic/cubit/cart_cubit.dart';
import 'past_record_selector.dart';

class PasteLinkBottomSheet extends StatefulWidget {
  const PasteLinkBottomSheet(
      {super.key, required this.cartContext, required this.initialTabIndex});
  final BuildContext cartContext;
  final int initialTabIndex;

  @override
  State<PasteLinkBottomSheet> createState() => _PasteLinkBottomSheetState();
}

class _PasteLinkBottomSheetState extends State<PasteLinkBottomSheet> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.white,
          title: Text(
            context.el.addMediaTitle,
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
          color: ColorsManager.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
            child: ElevatedButton(
              onPressed: _selectedIndex == 1
                  ? widget.cartContext
                          .read<CartCubit>()
                          .linkController
                          .text
                          .isNullOrEmpty()
                      ? null
                      : () {
                          widget.cartContext.read<CartCubit>().setLink(
                              link: widget.cartContext
                                  .read<CartCubit>()
                                  .linkController
                                  .text);
                          Navigator.pop(context);
                        }
                  : () {
                      // Use the widget.cartContext which has access to CartCubit
                      widget.cartContext.pushNamed(
                        Routes.recordScreen,
                        arguments: {
                          'extraArgs': widget.cartContext.read<CartCubit>(),
                        },
                      );
                    },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: ColorsManager.mainRose,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: _selectedIndex == 1
                  ? Text(
                      context.el.addToMessageButton,
                      style: GoogleFonts.inter(
                        color: ColorsManager.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svgs/video.svg",
                          colorFilter: const ColorFilter.mode(
                              ColorsManager.white, BlendMode.srcIn),
                        ),
                        SizedBox(width: 8.0.w),
                        Text(
                          context.el.startRecordingButton,
                          style: GoogleFonts.inter(
                            color: ColorsManager.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.el.mediaIntroText,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: PastRecordSelector(
                  selectedIndex: _selectedIndex,
                  onTabSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  initialTabIndex: _selectedIndex,
                ),
              ),
              SizedBox(height: 16.0.h),
              Text(
                context.el.howItWorks,
                style: GoogleFonts.inter(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.darkGray,
                ),
              ),
              SizedBox(height: 8.0.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.star,
                      size: 14.0, color: ColorsManager.mainRose),
                  SizedBox(width: 8.0.w),
                  Expanded(
                    child: Text(
                      _selectedIndex == 1
                          ? context.el.pasteLinkInstruction
                          : context.el.recordVideoInstruction,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: ColorsManager.black,
                      ),
                    ),
                  ),
                ],
              ),
              if (_selectedIndex == 0)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.star,
                        size: 14.0, color: ColorsManager.mainRose),
                    SizedBox(width: 8.0.w),
                    Expanded(
                      child: Text(
                        context.el.freeLabel,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          color: ColorsManager.black,
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 8.0.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.star,
                      size: 14.0, color: ColorsManager.mainRose),
                  SizedBox(width: 8.0.w),
                  Expanded(
                    child: Text(
                      context.el.qrCodeLabel,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: ColorsManager.black,
                      ),
                    ),
                  ),
                ],
              ),
              if (_selectedIndex == 1) SizedBox(height: 16.0.h),
              if (_selectedIndex == 1)
                TextField(
                  controller:
                      widget.cartContext.read<CartCubit>().linkController,
                  decoration: InputDecoration(
                    hintText: context.el.pasteLinkHint,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: ColorsManager.lightGrey,
                    ),
                    prefixIcon: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SvgPicture.asset(
                        "assets/svgs/link.svg",
                        colorFilter: const ColorFilter.mode(
                            ColorsManager.darkGray, BlendMode.srcIn),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorsManager.lightGrey,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorsManager.lightLighterGrey,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
