import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import '../../search/logic/cubit/search_cubit.dart';
import '../../search/logic/cubit/search_state.dart';
import '../../search/ui/widgets/filter_fab.dart';
import '../../search/ui/widgets/search_bloc_listener.dart';
import '../../search/ui/widgets/search_body.dart';

class CategoryScreen extends StatefulWidget {
  final String momentTitle;
  final String? occasionId;
  final String? categoryId;
  final String? subCategoryId;
  final String? recipientId;
  final String? brandId;
  final bool? expressDelivery;

  const CategoryScreen({
    super.key,
    required this.momentTitle,
    this.occasionId,
    this.categoryId,
    this.subCategoryId,
    this.recipientId,
    this.brandId,
    this.expressDelivery,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize search based on available parameters
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get navigation state

      // Use navigation state values if available, otherwise fall back to widget parameters
      final String? occasionId = widget.occasionId;
      final String? categoryId = widget.categoryId;
      final String? subCategoryId = widget.subCategoryId;
      final String? recipientId = widget.recipientId;
      final String? brandId = widget.brandId;
      final bool? expressDelivery = widget.expressDelivery;
      log('expressDelivery: $expressDelivery');
      // Set express delivery if needed
      if (expressDelivery != null && expressDelivery) {
        context.read<SearchCubit>().emitSearchStates(expressDelivery: true);
      } else if (brandId != null) {
        // For brands, use only the brandId
        context.read<SearchCubit>().emitSearchStates(
              filterBrand: brandId,
            );
      } else if (recipientId != null) {
        // For recipients, use only the recipientId
        context.read<SearchCubit>().emitSearchStates(
              filterRecipients: recipientId,
            );
      } else if (occasionId != null) {
        // For occasions, use only the occasionId
        context.read<SearchCubit>().emitSearchStates(
              filterOccasion: occasionId,
            );
      } else if (categoryId != null) {
        // For categories, use only the categoryId
        context.read<SearchCubit>().emitSearchStates(
              filterCategory: categoryId,
            );
      } else if (subCategoryId != null) {
        // For subcategories, use only the subCategoryId
        context.read<SearchCubit>().emitSearchStates(
              filterSubCategory: subCategoryId,
            );
      } else {
        // Fallback to title search for backward compatibility
        context.read<SearchCubit>().emitSearchStates(
              search: widget.momentTitle,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsManager.offWhite,
          floatingActionButton: (state is! Initial && state is! Loading)
              ? FilterFAB(
                  onPressed: () => _showFilterBottomSheet(context),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
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
              widget.momentTitle,
              style: GoogleFonts.ebGaramond(
                color: ColorsManager.mainRose,
                fontWeight: FontWeight.w400,
                fontSize: 30.0.sp,
              ),
            ),
            backgroundColor:
                ColorsManager.offWhite, // Make the AppBar transparent
            elevation: 0, // Remove AppBar shadow
          ),
          body: const Column(
            children: [
              SearchBlocListener(),
              Expanded(child: SearchBody()),
            ],
          ),
        );
      },
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    cubit.emitFilterDataStates();
  }
}
