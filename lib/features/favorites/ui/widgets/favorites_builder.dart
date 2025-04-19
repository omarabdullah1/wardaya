import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/features/favorites/logic/cubit/favorites_cubit.dart';
import 'package:wardaya/features/favorites/logic/cubit/favorites_state.dart';
import 'package:wardaya/features/favorites/ui/widgets/favorite_item_tile.dart';
import 'package:wardaya/features/favorites/ui/widgets/favorites_empty_view.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../data/models/get_favorites_response.dart';

class FavoritesBuilder extends StatelessWidget {
  const FavoritesBuilder({super.key});

  Widget _buildLoadingState(BuildContext context, bool isDialog) {
    if (isDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Check if the context is still mounted before showing dialog
        if (context.mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const LoadingWidget(
              loadingState: true,
            ),
          );
        }
      });
    }
    return Skeletonizer(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: FavoriteItemTile(
              item: GetFavoriteProduct(
                id: '1',
                title: 'Loading Item',
                price: Price(
                  total: 100,
                  currency: 'EGP',
                ),
                images: [],
                description: 'This is a loading placeholder',
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadedState(
      BuildContext context, GetFavoritesResponse favorites) {
    if (favorites.favorites.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Check if the context is still mounted before popping
        if (context.mounted && Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
      return const FavoritesEmptyView();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Check if the context is still mounted before popping
      if (context.mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favorites.favorites.length,
      itemBuilder: (context, index) {
        final GetFavoriteProduct item = favorites.favorites[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FavoriteItemTile(
            item: item,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      buildWhen: (previous, current) =>
          current is AddFavoriteSuccess ||
          current is DeleteFavoriteSuccess ||
          current is GetFavoritesSuccess ||
          current is Error ||
          current is Loading,
      builder: (context, state) {
        return state.maybeWhen(
          // initial: () => _buildLoadingState(context),
          loading: () => _buildLoadingState(context, true),
          getFavoritesSuccess: (GetFavoritesResponse favorites) =>
              _buildLoadedState(context, favorites),
          deleteFavoriteSuccess: (response) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Check if the context is still mounted before popping
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            });
            // Show a snackbar if the product was not found in favorites
            if (response.message
                    ?.toLowerCase()
                    .contains('not found in favorites') ??
                false) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          response.message ?? 'Product not found in favorites'),
                      backgroundColor: Colors.orange,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              });
            }
            // Refresh the favorites list to get the updated state
            // Check if the cubit is still active before calling getFavorites
            if (context.mounted) {
              final cubit = context.read<FavoritesCubit>();
              // Only call getFavorites if the cubit is not closed
              if (!cubit.isClosed) {
                cubit.getFavorites();
              }
            }
            // Return loading state while refreshing
            return _buildLoadingState(context, false);
          },
          error: (message) {
            // Show error message in a snackbar
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                // Check if we can pop before trying to pop to first route
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            });
            return const SizedBox.shrink();
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }
}
