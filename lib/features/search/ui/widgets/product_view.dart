import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import '../../../../core/routing/routes.dart';
import '../../logic/cubit/search_cubit.dart';
import '../../logic/cubit/search_state.dart';
import 'product_item.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return cubit.isGridView ? _buildGrid(context) : _buildList(context);
      },
    );
  }

  Widget _buildGrid(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.60,
          ),
          itemCount: cubit.filteredProducts.length,
          itemBuilder: (context, index) => ProductItem(
            product: cubit.filteredProducts[index],
            isGrid: true,
            onTap: (p0) {
              context.pushNamed(
                Routes.productDetailsScreen,
                arguments: {'extraArgs': cubit.filteredProducts[index]},
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildList(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: cubit.filteredProducts.length,
          itemBuilder: (context, index) => ProductItem(
            product: cubit.filteredProducts[index],
            isGrid: false,
            onTap: (p0) {
              context.pushNamed(
                Routes.productDetailsScreen,
                arguments: {'extraArgs': cubit.filteredProducts[index]},
              );
            },
          ),
        );
      },
    );
  }
}
