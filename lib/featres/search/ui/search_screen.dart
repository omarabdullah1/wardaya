import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/helpers/extensions.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
            kToolbarHeight + 20), // Add some extra space for padding
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
                  color: Color(0xff074E59),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 240, 240),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Material(
                    elevation: 2.8, // Set the elevation for shadow
                    borderRadius: BorderRadius.circular(30.0),

                    child: SizedBox(
                      height: 40.h,
                      child: CupertinoSearchTextField(
                        placeholder: 'Search for flowers, gifts, and more',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp,
                        ),
                        prefixIcon: const Icon(
                          CupertinoIcons.search,
                          color: Color(0xff074E59),
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
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // Handle button press
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(context.pOW(45).w, context.pOH(4.0).h),
              alignment: AlignmentDirectional.center,
              backgroundColor: const Color(0xff074E59),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 8.0),
                Text(
                  'Search',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
