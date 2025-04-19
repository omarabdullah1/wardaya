import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/add_favorites_response.dart';
import '../../data/models/delete_favorites_response.dart';
import '../../data/models/get_favorites_response.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.initial() = _Initial;
  const factory FavoritesState.loading() = Loading;

  // Add favorite states
  const factory FavoritesState.addFavoriteSuccess(
      AddFavoritesResponse response) = AddFavoriteSuccess;
  const factory FavoritesState.addFavoriteError(String message) =
      AddFavoriteError;

  // Get favorites states
  const factory FavoritesState.getFavoritesSuccess(
      GetFavoritesResponse response) = GetFavoritesSuccess;

  // Delete favorite states
  const factory FavoritesState.deleteFavoriteSuccess(
      DeleteFavoritesResponse response) = DeleteFavoriteSuccess;

  const factory FavoritesState.error(String message) = Error;
  const factory FavoritesState.toggleFavorite(String itemId, bool isFavorite) =
      ToggleFavorite;
}
