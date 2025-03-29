import 'dart:developer';

import 'package:wardaya/features/search/data/apis/search_api_constants.dart';
import 'package:wardaya/features/search/data/models/filter_data_body.dart';
import 'package:wardaya/features/search/data/models/search_request_body.dart';
import 'package:wardaya/features/search/data/repos/search_repo.dart';

import '../../../../core/routing/router_imports.dart';
import '../../data/models/search_response.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _searchRepo;
  SearchCubit(this._searchRepo) : super(const SearchState.initial());

  TextEditingController searchController = TextEditingController();
  List<Product> originalProducts = [];
  List<Product> filteredProducts = [];
  bool isGridView = true;
  Map<String, String?> selectedFilters = {};
  Map<String, String?> tempFilters = {};

  // Helper method to process image URLs
  String getCompleteImageUrl(String relativePath) {
    if (relativePath.startsWith('http')) {
      return relativePath;
    }

    const baseUrl = SearchApiConstants.apiBaseUrlForImages;

    // Handle path with or without leading slash
    if (relativePath.startsWith('/')) {
      return '$baseUrl$relativePath';
    } else {
      return '$baseUrl/$relativePath';
    }
  }

  void emitSearchStates({
    String? search,
    String? filterCategory,
    String? filterOccasion,
    String? filterRecipients,
    String? filterColor,
    String? filterBundleTypes,
    String? filterPriceRange,
  }) async {
    emit(const SearchState.loading());
    try {
      final response = await _searchRepo.search(SearchRequestBody(
        limit: 10,
        page: 1,
        search: search ?? searchController.text,
        category: filterCategory,
        occasion: filterOccasion,
        recipients: filterRecipients,
        color: filterColor,
        bundleTypes: filterBundleTypes,
        priceRange: filterPriceRange,
      ));

      response.when(success: (SearchResponse data) {
        // Process images for all products
        for (var product in data.products) {
          for (int i = 0; i < product.images.length; i++) {
            product.images[i] = getCompleteImageUrl(product.images[i]);
          }
        }
        originalProducts = data.products;
        filteredProducts = data.products;
        emit(SearchState.success(data));
      }, failure: (error) {
        emit(SearchState.error(error.message ?? 'Unknown error occurred'));
      });
    } catch (e, stackTrace) {
      log('Search error: $e', stackTrace: stackTrace);
      emit(SearchState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }

  void setIsGridView(bool isGrid) {
    isGridView = isGrid;
    emit(SearchState.setIsGridView(isGrid));
  }

  void applyFilters(Map<String, String?> filters) {
    log(filters.toString());
    selectedFilters = filters;

    // If no filters are selected, show all products
    if (filters.values.every((value) => value == null)) {
      filteredProducts = originalProducts;
      emitSearchStates(
        filterCategory: filters["category"],
        filterOccasion: filters["occasion"],
        filterRecipients: filters["recipient"],
        filterColor: filters["color"],
        filterBundleTypes: filters["bundleTypes"],
        filterPriceRange: filters["priceRange"],
      );
      return;
    }

    // // Filter the products based on selected filters
    // filteredProducts = originalProducts.where((product) {
    //   bool categoryMatch = filters["category"] == null ||
    //       product.subCategories.any((cat) => cat.name == filters["category"]);

    //   bool occasionMatch = filters["occasion"] == null ||
    //       (product.occasions.isNotEmpty &&
    //           product.occasions.any((occ) => occ.name == filters["occasion"]));

    //   bool recipientMatch = filters["recipient"] == null ||
    //       (product.recipients.isNotEmpty &&
    //           product.recipients
    //               .any((rec) => rec.name == filters["recipient"]));

    //   bool colorMatch = filters["color"] == null ||
    //       (product.colors.isNotEmpty &&
    //           product.colors.any((col) => col.name == filters["color"]));

    //   return categoryMatch && occasionMatch && recipientMatch && colorMatch;
    // }).toList();
    // emit(SearchState.applyFilters(selectedFilters));
    emitSearchStates(
      filterCategory: filters["category"],
      filterOccasion: filters["occasion"],
      filterRecipients: filters["recipient"],
      filterColor: filters["color"],
      filterBundleTypes: filters["bundleTypes"],
      filterPriceRange: filters["priceRange"],
    );
  }

  void setTempFilter(Map<String, String?> filters) {
    tempFilters = filters;
    emit(SearchState.setTempFilters(filters));
  }

  void setTempFilterTypeValue(String filterType, String? value) {
    tempFilters = Map<String, String?>.from(selectedFilters);

    if (value == null) {
      tempFilters.remove(filterType);
    } else {
      tempFilters[filterType] = value;
    }
    selectedFilters = tempFilters;
    emit(SearchState.setTempFiltersTypeValue(filterType, value));
  }

  void emitFilterDataStates({
    String? filterCategory,
    String? filterOccasion,
    String? filterRecipients,
    String? filterColor,
  }) async {
    emit(const SearchState.loadingFilterData());
    final response = await _searchRepo.productFilterData(FilterDataBody(
      category: filterCategory,
      occasion: filterOccasion,
      recipients: filterRecipients,
      color: filterColor,
    ));
    response.when(success: (data) {
      emit(SearchState.successFilterData(data));
    }, failure: (error) {
      emit(SearchState.errorFilterData(error.message ?? ''));
    });
  }
}
