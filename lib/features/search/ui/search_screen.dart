import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/blocs/general/cubit/general_cubit.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight + 30.h), // Add some extra space for padding
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          margin: EdgeInsets.only(
              top: context.pOH(5).h), // Padding around the content
          color: Colors
              .transparent, // Optional: You can add a background color here if needed.
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorsManager.mainRose,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 240, 240),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Material(
                    elevation: 2.8, // Set the elevation for shadoww
                    borderRadius: BorderRadius.circular(30.0),
                    child: SizedBox(
                      height: 40.h,
                      child: CupertinoSearchTextField(
                        placeholder: context.el.searchPlaceholder,
                        style: GoogleFonts.inter(
                          color: ColorsManager.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),
                        prefixIcon: const Icon(
                          CupertinoIcons.search,
                          color: ColorsManager.mainRose,
                        ),
                        itemSize: 24,
                        itemColor: Colors.black,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16)
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 25.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(context.screenWidth.w, 40.h),
                alignment: AlignmentDirectional.center,
                backgroundColor: ColorsManager.mainRose,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: context.watch<GeneralCubit>().lang == 'ar'
                      ? [
                          Text(
                            context.el.searchButton,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(width: 8.0),
                          const Icon(Icons.search, color: Colors.white),
                        ]
                      : [
                          const Icon(Icons.search, color: Colors.white),
                          const SizedBox(width: 8.0),
                          Text(
                            context.el.searchButton,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
