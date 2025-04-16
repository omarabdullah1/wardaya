import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
        return cubit.isGridView ? _buildGrid(context) : _buildList(context);
      },
    );
  }

  Widget _buildGrid(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is Loading && cubit.filteredProducts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels ==
                    scrollNotification.metrics.maxScrollExtent &&
                !cubit.isLoadingMore &&
                cubit.hasMorePages) {
              cubit.loadMoreProducts();
            }
            return false;
          },
          child: Stack(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.60,
                  ),
                  itemCount: cubit.filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductItem(
                      product: cubit.filteredProducts[index],
                      isGrid: true,
                      onTap: (p0) {
                        context.pushNamed(
                          Routes.productDetailsScreen,
                          arguments: {
                            'extraArgs': cubit.filteredProducts[index]
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              if (cubit.hasMorePages && cubit.isLoadingMore)
                Positioned(
                  bottom: 0.0,
                  left: (context.screenWidth * 0.40).w,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildList(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        // Show centered loading when first loading and no products
        if (state is Loading && cubit.filteredProducts.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification.metrics.pixels ==
                    scrollNotification.metrics.maxScrollExtent &&
                !cubit.isLoadingMore &&
                cubit.hasMorePages) {
              cubit.loadMoreProducts();
            }
            return false;
          },
          child: ListView.builder(
            itemCount:
                cubit.filteredProducts.length + (cubit.hasMorePages ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= cubit.filteredProducts.length) {
                return const SizedBox(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ProductItem(
                product: cubit.filteredProducts[index],
                isGrid: false,
                onTap: (p0) {
                  context.pushNamed(
                    Routes.productDetailsScreen,
                    arguments: {'extraArgs': cubit.filteredProducts[index]},
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
