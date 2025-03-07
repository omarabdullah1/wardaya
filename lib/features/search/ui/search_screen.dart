import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theming/colors.dart';
import '../logic/cubit/search_cubit.dart';
import '../logic/cubit/search_state.dart';
import 'widgets/filter_fab.dart';
import 'widgets/search_app_bar.dart';
import 'widgets/filter_bottom_sheet.dart';
import 'widgets/search_bloc_listener.dart';
import 'widgets/search_body.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        // final cubit = context.read<SearchCubit>();
        return Scaffold(
          backgroundColor: ColorsManager.offWhite,
          floatingActionButton: (state is! Initial && state is! Loading)
              ? FilterFAB(
                  onPressed: _showFilterBottomSheet,
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: const SearchAppBar(),
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

  void _showFilterBottomSheet() {
    // final cubit = context.read<SearchCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<SearchCubit>(),
        child: const FilterBottomSheet(),
      ),
    );
  }
}
