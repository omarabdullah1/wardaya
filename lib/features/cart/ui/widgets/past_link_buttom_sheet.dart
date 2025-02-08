import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
            'Add a Video or Photo',
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
                      context.pushNamed(Routes.recordScreen);
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
                      "Add to Message",
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
                          'Start Recording',
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
              const Text(
                "Words are tough? Express yourself with a video or a photo.",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500), //Customize Style
              ),
              const SizedBox(height: 16.0),
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
              const SizedBox(height: 16.0),
              Text(
                "How it works?",
                style: GoogleFonts.inter(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.darkGray,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.star,
                      size: 14.0, color: ColorsManager.mainRose),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      _selectedIndex == 1
                          ? "Paste a link of video or photo from the internet"
                          : 'Record a 10-second video or take a picture',
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
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        "Free",
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
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      "A QR code will be added to your card message",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: ColorsManager.black,
                      ),
                    ),
                  ),
                ],
              ),
              if (_selectedIndex == 1) const SizedBox(height: 16.0),
              if (_selectedIndex == 1)
                TextField(
                  controller:
                      widget.cartContext.read<CartCubit>().linkController,
                  decoration: InputDecoration(
                    hintText: "Paste your link here",
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
