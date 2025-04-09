import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wardaya/features/favorites/data/models/get_favorites_response.dart';
import 'package:wardaya/features/favorites/data/repos/favorites_repo.dart';
import 'package:wardaya/features/favorites/data/models/add_favorites_response.dart';
import 'package:wardaya/features/favorites/data/models/delete_favorites_response.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  // List to store favorite items from server response
  List<dynamic> _favorites = [];
  final FavoritesRepo _favoritesRepo;
  FavoritesCubit(this._favoritesRepo) : super(const FavoritesState.initial());

  // Get all favorites from server
  Future<void> getFavorites() async {
    emit(const FavoritesState.loading());
    try {
      final response = await _favoritesRepo.getFavorites();
      response.when(
        success: (GetFavoritesResponse data) {
          log('data: $data');
          log('Successfully received favorites data with ${data.favorites.length} items');
          _favorites = data.favorites;
          emit(FavoritesState.getFavoritesSuccess(data));
        },
        failure: (error) {
          log('Error fetching favorites data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(FavoritesState.error(
              error.message ?? 'Failed to fetch favorites data'));
        },
      );
    } catch (e, stackTrace) {
      log('favorites unexpected error: $e', stackTrace: stackTrace);
      emit(FavoritesState.error(
          'An unexpected error occurred: ${e.toString()}'));
    }
  }

  // Add item to favorites using API
  Future<void> addToFavorites(dynamic item) async {
    emit(const FavoritesState.loading());
    try {
      final response = await _favoritesRepo.addToFavorites(item);
      response.when(
        success: (AddFavoritesResponse data) {
          log('data: $data');
          // If we get a message about product already in favorites, treat it as success
          if (data.message?.toLowerCase().contains('already in favorites') ??
              false) {
            // Don't update _favorites list since the product is already there
            emit(FavoritesState.addFavoriteSuccess(data));
            return;
          }
          // Only update _favorites if we have a new list
          if (data.favorites != null) {
            log('Successfully added favorites data with ${data.favorites!.length} items');
            _favorites = data.favorites!;
          }
          emit(FavoritesState.addFavoriteSuccess(data));
        },
        failure: (error) {
          log('Error adding favorites data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(FavoritesState.error(
              error.message ?? 'Failed to add favorites data'));
        },
      );
    } catch (e, stackTrace) {
      log('favorites unexpected error: $e', stackTrace: stackTrace);
      emit(FavoritesState.error(
          'An unexpected error occurred: ${e.toString()}'));
    }
  }

  // Remove item from favorites using API
  Future<void> removeFromFavorites(String productId) async {
    emit(const FavoritesState.loading());
    final result = await _favoritesRepo.deleteFromFavorites(productId);
    result.when(
      success: (response) {
        // If we get a message about product not being in favorites,
        // we should still consider it a success and remove it from our local list
        if (response.message
                ?.toLowerCase()
                .contains('not found in favorites') ??
            false) {
          _favorites.removeWhere((item) => item.id == productId);
          emit(FavoritesState.deleteFavoriteSuccess(response));
          return;
        }

        // If we have a new favorites list, update it
        if (response.favorites != null) {
          _favorites = response.favorites!;
        } else {
          // If no new list is provided, just remove the item from our local list
          _favorites.removeWhere((item) => item.id == productId);
        }
        emit(FavoritesState.deleteFavoriteSuccess(response));
      },
      failure: (error) {
        emit(FavoritesState.error(
            error.message ?? 'Failed to remove from favorites'));
      },
    );
  }

  // Toggle favorite status
  Future<void> toggleFavorite(dynamic item) async {
    if (isItemFavorite(item['id'])) {
      await removeFromFavorites(item['id']);
    } else {
      await addToFavorites(item);
    }
  }

  // Check if item is in favorites
  bool isItemFavorite(String itemId) {
    if (_favorites.isEmpty) return false;

    try {
      // First attempt: Check for GetFavoriteProduct objects
      for (final item in _favorites) {
        if (item is GetFavoriteProduct && item.id == itemId) {
          return true;
        }
      }

      // Second attempt: Check for AddFavoriteProduct objects
      for (final item in _favorites) {
        if (item is AddFavoriteProduct && item.id == itemId) {
          return true;
        }
      }

      // Third attempt: Check for DeleteFavoriteProduct objects
      for (final item in _favorites) {
        if (item is DeleteFavoriteProduct && item.id == itemId) {
          return true;
        }
      }

      // Fourth attempt: Check for map-like objects using item['id'] or item['_id']
      for (final item in _favorites) {
        if (item is Map && (item['id'] == itemId || item['_id'] == itemId)) {
          return true;
        }
      }

      // If all checks fail, the item is not in favorites
      return false;
    } catch (e) {
      log('Error checking if item is in favorites: $e');
      return false;
    }
  }
}
