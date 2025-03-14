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
  const CategoryScreen({super.key, required this.momentTitle});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize search with moment title as category
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchCubit>().emitSearchStates(
            search: widget.momentTitle,
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
