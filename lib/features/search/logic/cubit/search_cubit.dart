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
  Map<String, String?> initialFilter = {};
  Map<String, List<String>> filterLists = {};

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
    String? filterSubCategory,
    String? filterOccasion,
    String? filterRecipients,
    String? filterColor,
    String? filterBundleTypes,
    String? filterPriceRange,
    String? filterBrand,
    bool? expressDelivery,
  }) async {
    emit(const SearchState.loading());
    try {
      // Only use search parameter if it's not empty or null
      String? searchText;
      if (search?.isNotEmpty ?? false) {
        searchText = search;
      } else if (searchController.text.isNotEmpty) {
        searchText = searchController.text;
      }

      // Store the initial filter if this is the first search
      if (initialFilter.isEmpty) {
        if (filterCategory != null) {
          initialFilter['category'] = filterCategory;
          // Initialize the filter list with the initial category
          filterLists['category'] = [filterCategory];
        }
        if (filterSubCategory != null) {
          initialFilter['subCategory'] = filterSubCategory;
          filterLists['subCategory'] = [filterSubCategory];
        }
        if (filterOccasion != null) {
          initialFilter['occasion'] = filterOccasion;
          filterLists['occasion'] = [filterOccasion];
        }
        if (filterRecipients != null) {
          initialFilter['recipient'] = filterRecipients;
          filterLists['recipient'] = [filterRecipients];
        }
        if (filterColor != null) {
          initialFilter['color'] = filterColor;
        }
        if (filterBundleTypes != null) {
          initialFilter['bundleTypes'] = filterBundleTypes;
          filterLists['bundleTypes'] = [filterBundleTypes];
        }
        if (filterPriceRange != null) {
          initialFilter['priceRange'] = filterPriceRange;
          filterLists['priceRange'] = [filterPriceRange];
        }
        if (filterBrand != null) {
          initialFilter['brand'] = filterBrand;
          filterLists['brand'] = [filterBrand];
        }
        if (expressDelivery != null) {
          initialFilter['expressDelivery'] = expressDelivery.toString();
        }
      }

      // Add a timeout for the entire operation
      final response = await _searchRepo.search(SearchRequestBody(
        limit: 10,
        page: 1,
        search: searchText,
        category:
            filterLists['category']?.join(','), // Join category list values
        subCategory: filterLists['subCategory']?.join(','),
        occasion: filterLists['occasion']?.join(','),
        recipients: filterLists['recipient']?.join(','),
        color: filterLists['color']?.join(','),
        bundleTypes: filterLists['bundleTypes']?.join(','),
        priceRange: filterLists['priceRange']?.join(','),
        brand: filterLists['brand']?.join(','),
        expressDelivery: expressDelivery,
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
        // Check if this is a 504 error and provide a more specific message
        if (error.message?.contains('504') == true) {
          emit(const SearchState.error(
              'Server is taking too long to respond. Please try again in a moment.'));
        } else {
          emit(SearchState.error(error.message ?? 'Unknown error occurred'));
        }
      });
    } catch (e, stackTrace) {
      log('Search error: $e', stackTrace: stackTrace);

      // Check if this is a 504 error and provide a more specific message
      if (e.toString().contains('504')) {
        emit(const SearchState.error(
            'Server is taking too long to respond. Please try again in a moment.'));
      } else {
        emit(
            SearchState.error('An unexpected error occurred: ${e.toString()}'));
      }
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
      // Reset filter lists when clearing filters
      filterLists.clear();
      // Restore initial category if it exists
      if (initialFilter['category'] != null) {
        filterLists['category'] = [initialFilter['category']!];
      }
      emitSearchStates(
        filterCategory: filters["category"],
        filterSubCategory: filters["subCategory"],
        filterOccasion: filters["occasion"],
        filterRecipients: filters["recipient"],
        filterColor: filters["color"],
        filterBundleTypes: filters["bundleTypes"],
        filterPriceRange: filters["priceRange"],
        expressDelivery: filters["expressDelivery"] == "true",
      );
      return;
    }

    // Get current search text if present
    String? searchText =
        searchController.text.isNotEmpty ? searchController.text : null;

    emitSearchStates(
      search: searchText,
      filterCategory: filters["category"],
      filterSubCategory: filters["subCategory"],
      filterOccasion: filters["occasion"],
      filterRecipients: filters["recipient"],
      filterColor: filters["color"],
      filterBundleTypes: filters["bundleTypes"],
      filterPriceRange: filters["priceRange"],
      expressDelivery: filters["expressDelivery"] == "true",
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
      filterLists[filterType]?.remove(value);
      if (filterLists[filterType]?.isEmpty == true) {
        filterLists.remove(filterType);
      }
    } else {
      tempFilters[filterType] = value;
      if (filterType == 'category') {
        if (!filterLists.containsKey(filterType)) {
          filterLists[filterType] = [];
        }
        if (!filterLists[filterType]!.contains(value)) {
          filterLists[filterType]!.add(value);
        }
      }
    }
    selectedFilters = tempFilters;
    emit(SearchState.setTempFiltersTypeValue(filterType, value));
  }

  void emitFilterDataStates({
    String? filterCategory,
    String? filterSubCategory,
    String? filterOccasion,
    String? filterRecipients,
    String? filterColor,
  }) async {
    emit(const SearchState.loadingFilterData());

    // Only pass non-empty parameters
    final category = filterCategory?.isNotEmpty == true ? filterCategory : null;
    final subCategory =
        filterSubCategory?.isNotEmpty == true ? filterSubCategory : null;
    final occasion = filterOccasion?.isNotEmpty == true ? filterOccasion : null;
    final recipients =
        filterRecipients?.isNotEmpty == true ? filterRecipients : null;
    final color = filterColor?.isNotEmpty == true ? filterColor : null;

    final response = await _searchRepo.productFilterData(FilterDataBody(
      category: category,
      subCategory: subCategory,
      occasion: occasion,
      recipients: recipients,
      color: color,
    ));
    response.when(success: (data) {
      emit(SearchState.successFilterData(data));
    }, failure: (error) {
      emit(SearchState.errorFilterData(error.message ?? ''));
    });
  }
}
