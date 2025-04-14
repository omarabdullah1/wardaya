import 'dart:convert';
import 'get_favorites_response.dart';

/// Helper class for handling various response formats from the favorites API
class FavoritesResponseHelper {
  /// Handles parsing responses that might be a direct list or a wrapped object
  static GetFavoritesResponse parseGetFavoritesResponse(dynamic response) {
    // If response is already parsed to a Map or List
    if (response is Map<String, dynamic>) {
      // If response has a 'favorites' field
      if (response.containsKey('favorites') && response['favorites'] is List) {
        return GetFavoritesResponse.fromJson(response);
      } else {
        // Create an empty response as fallback
        return GetFavoritesResponse(favorites: []);
      }
    }
    // If response is a direct list of favorites
    else if (response is List) {
      // Convert the list to GetFavoriteProduct objects
      final favoritesList = response
          .map((item) => item is Map<String, dynamic> 
              ? GetFavoriteProduct.fromJson(item)
              : null)
          .where((item) => item != null)
          .cast<GetFavoriteProduct>()
          .toList();
      
      return GetFavoritesResponse(favorites: favoritesList);
    }
    // If response is a JSON string 
    else if (response is String) {
      try {
        final decoded = json.decode(response);
        if (decoded is List) {
          // Convert the decoded list to GetFavoriteProduct objects
          final favoritesList = decoded
              .map((item) => item is Map<String, dynamic> 
                  ? GetFavoriteProduct.fromJson(item)
                  : null)
              .where((item) => item != null)
              .cast<GetFavoriteProduct>()
              .toList();
          
          return GetFavoritesResponse(favorites: favoritesList);
        } else if (decoded is Map<String, dynamic>) {
          if (decoded.containsKey('favorites') &&
              decoded['favorites'] is List) {
            return GetFavoritesResponse.fromJson(decoded);
          }
        }
      } catch (e) {
        // Handle JSON parsing error
      }
      // Return empty response as fallback
      return GetFavoritesResponse(favorites: []);
    }
    // Default to empty response for any other case
    else {
      return GetFavoritesResponse(favorites: []);
    }
  }
}
