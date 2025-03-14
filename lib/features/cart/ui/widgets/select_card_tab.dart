import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/cart_cubit.dart';

class SelectCardTab extends StatelessWidget {
  final int selectedCardIndex;
  final ValueChanged<int> onCardSelected;

  const SelectCardTab({
    super.key,
    required this.selectedCardIndex,
    required this.onCardSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cards = context.read<CartCubit>().cards;
    return ListView.builder(
      itemCount: cards(context).length,
      itemBuilder: (_, index) {
        final card = cards(context)[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: selectedCardIndex == index
                    ? ColorsManager.mainRose
                    : ColorsManager.transparent,
                width: 2,
              ),
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                InkWell(
                  onTap: () => onCardSelected(index),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      card['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300.h,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0, // Or calculate left for centering
                  child: Align(
                    alignment: Alignment.bottomLeft, // Or Alignment.center
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorsManager.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisSize:
                            MainAxisSize.min, // Essential for fitting content
                        children: [
                          Text(
                            card['title'],
                            style: GoogleFonts.inter(
                              color: ColorsManager.mainRose,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            ' | ${card['currency']}${card['price']}',
                            style: GoogleFonts.inter(
                              color: ColorsManager.mainRose,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: () => onCardSelected(index),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedCardIndex == index
                              ? ColorsManager.mainRose
                              : ColorsManager.white,
                          border: Border.all(color: ColorsManager.grey),
                        ),
                        child: Icon(
                          Icons.check,
                          color: selectedCardIndex == index
                              ? ColorsManager.white
                              : ColorsManager.transparent,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
