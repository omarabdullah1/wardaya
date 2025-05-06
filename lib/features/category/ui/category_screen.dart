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
  final String? subMenuItemsId;
  final bool? expressDelivery;

  const CategoryScreen({
    super.key,
    required this.momentTitle,
    this.occasionId,
    this.categoryId,
    this.subCategoryId,
    this.recipientId,
    this.brandId,
    this.subMenuItemsId,
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
      log('CategoryScreen initState');
      log(widget.momentTitle);
      log(widget.occasionId.toString());
      log(widget.categoryId.toString());
      log(widget.subCategoryId.toString());
      log(widget.recipientId.toString());
      log(widget.brandId.toString());
      log(widget.subMenuItemsId.toString());
      log(widget.expressDelivery.toString());

      // Use all available filters simultaneously
      context.read<SearchCubit>().emitSearchStates(
            expressDelivery: widget.expressDelivery,
            filterBrand: widget.brandId,
            filterRecipients: widget.recipientId,
            filterOccasion: widget.occasionId,
            filterCategory: widget.categoryId,
            filterSubCategory: widget.subCategoryId,
            filterSubMenuItems: widget.subMenuItemsId,
          );
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
              icon: Icon(
                Icons.arrow_back_ios,
                color: ColorsManager.mainRose,
                size: 18.0.h,
              ),
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
