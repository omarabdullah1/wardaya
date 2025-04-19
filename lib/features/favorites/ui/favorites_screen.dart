import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/favorites/logic/cubit/favorites_cubit.dart';

import 'widgets/favorites_builder.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.mainRose,
          ), // Back button
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          context.el.favoritesScreenTitle,
          style: GoogleFonts.inter(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w700,
            fontSize: 18.0.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            ColorsManager.transparent, // Make the AppBar transparent
        elevation: 0, // Remove AppBar shadow
      ),
      body: RefreshIndicator(
        color: ColorsManager.mainRose,
        onRefresh: () async {
          context.read<FavoritesCubit>().getFavorites();
        },
        child: const FavoritesBuilder(),
      ),
    );
  }
}
