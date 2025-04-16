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

  // Pagination variables
  int currentPage = 1;
  bool hasMorePages = true;
  bool isLoadingMore = false;
  SearchResponse? currentResponse;

  String getCompleteImageUrl(String relativePath) {
    if (relativePath.startsWith('http')) {
      return relativePath;
    }
    const baseUrl = SearchApiConstants.apiBaseUrlForImages;
    return relativePath.startsWith('/')
        ? '$baseUrl$relativePath'
        : '$baseUrl/$relativePath';
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
    String? filterSubMenuItems,
    bool? expressDelivery,
    bool loadMore = false,
  }) async {
    if (loadMore) {
      if (isLoadingMore || !hasMorePages) return;
      isLoadingMore = true;
      currentPage++;
      emit(const SearchState.loading());
    } else {
      emit(const SearchState.loading());
      currentPage = 1;
      hasMorePages = true;
      currentResponse = null;
      originalProducts = [];
      filteredProducts = [];
    }

    try {
      String? searchText = search ??
          (searchController.text.isNotEmpty ? searchController.text : null);

      if (initialFilter.isEmpty && !loadMore) {
        _updateInitialFilters(
          filterCategory: filterCategory,
          filterSubCategory: filterSubCategory,
          filterOccasion: filterOccasion,
          filterRecipients: filterRecipients,
          filterColor: filterColor,
          filterBundleTypes: filterBundleTypes,
          filterPriceRange: filterPriceRange,
          filterBrand: filterBrand,
          filterSubMenuItems: filterSubMenuItems,
          expressDelivery: expressDelivery,
        );
      }

      final response = await _searchRepo.search(SearchRequestBody(
        limit: 10,
        page: currentPage,
        search: searchText,
        category: filterLists['category']?.join(','),
        subCategory: filterLists['subCategory']?.join(','),
        occasion: filterLists['occasion']?.join(','),
        recipients: filterLists['recipient']?.join(','),
        color: filterLists['color']?.join(','),
        bundleTypes: filterLists['bundleTypes']?.join(','),
        priceRange: filterLists['priceRange']?.join(','),
        brand: filterLists['brand']?.join(','),
        subMenuItems: filterLists['subMenuItems']?.join(','),
        expressDelivery: expressDelivery,
      ));

      response.when(
        success: (SearchResponse data) {
          _processResponse(data, loadMore: loadMore);
        },
        failure: (error) {
          if (loadMore) currentPage--;
          _handleError(error);
        },
      );
    } catch (e, stackTrace) {
      if (loadMore) currentPage--;
      _handleException(e, stackTrace);
    }
  }

  void _updateInitialFilters({
    String? filterCategory,
    String? filterSubCategory,
    String? filterOccasion,
    String? filterRecipients,
    String? filterColor,
    String? filterBundleTypes,
    String? filterPriceRange,
    String? filterBrand,
    String? filterSubMenuItems,
    bool? expressDelivery,
  }) {
    if (filterCategory != null) {
      initialFilter['category'] = filterCategory;
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
    if (filterSubMenuItems != null) {
      initialFilter['subMenuItems'] = filterSubMenuItems;
      filterLists['subMenuItems'] = [filterSubMenuItems];
    }
  }

  void _processResponse(SearchResponse data, {required bool loadMore}) {
    if (loadMore) {
      _handleLoadMoreResponse(data);
    } else {
      _handleInitialResponse(data);
    }
  }

  void _handleInitialResponse(SearchResponse data) {
    originalProducts = List.from(data.products);
    filteredProducts = List.from(data.products);
    hasMorePages = data.products.isNotEmpty && data.products.length >= 10;
    currentResponse = data;
    emit(SearchState.success(data));
  }

  void _handleLoadMoreResponse(SearchResponse data) {
    final newOriginalProducts = List<Product>.from(originalProducts)
      ..addAll(data.products);
    final newFilteredProducts = List<Product>.from(filteredProducts)
      ..addAll(data.products);

    originalProducts = newOriginalProducts;
    filteredProducts = newFilteredProducts;
    hasMorePages = data.products.isNotEmpty && data.products.length >= 10;
    isLoadingMore = false;
    currentResponse = data;

    emit(SearchState.success(SearchResponse(
      total: data.total,
      page: currentPage,
      limit: data.limit,
      totalPages: data.totalPages,
      products: newOriginalProducts,
    )));
  }

  void _handleError(error) {
    isLoadingMore = false;
    if (error.message?.contains('504') == true) {
      emit(const SearchState.error(
          'Server is taking too long to respond. Please try again in a moment.'));
    } else {
      emit(SearchState.error(error.message ?? 'Unknown error occurred'));
    }
  }

  void _handleException(e, StackTrace stackTrace) {
    isLoadingMore = false;
    log('Search error: $e', stackTrace: stackTrace);
    if (e.toString().contains('504')) {
      emit(const SearchState.error(
          'Server is taking too long to respond. Please try again in a moment.'));
    } else {
      emit(SearchState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }

  void loadMoreProducts() {
    emitSearchStates(
      loadMore: true,
      filterCategory: selectedFilters["category"],
      filterSubCategory: selectedFilters["subCategory"],
      filterOccasion: selectedFilters["occasion"],
      filterRecipients: selectedFilters["recipient"],
      filterColor: selectedFilters["color"],
      filterBundleTypes: selectedFilters["bundleTypes"],
      filterPriceRange: selectedFilters["priceRange"],
      filterSubMenuItems: selectedFilters["subMenuItems"],
      expressDelivery: selectedFilters["expressDelivery"] == "true",
    );
  }

  void setIsGridView(bool isGrid) {
    isGridView = isGrid;
    emit(SearchState.setIsGridView(isGrid));
  }

  void applyFilters(Map<String, String?> filters) {
    log(filters.toString());
    selectedFilters = filters;

    if (filters.values.every((value) => value == null)) {
      filteredProducts = List.from(originalProducts);
      filterLists.clear();
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
        filterSubMenuItems: filters["subMenuItems"],
        expressDelivery: filters["expressDelivery"] == "true",
      );
      return;
    }

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
