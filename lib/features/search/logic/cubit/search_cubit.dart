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

  void emitSearchStates() async {
    emit(const SearchState.loading());
    final response = await _searchRepo.search(SearchRequestBody(
      limit: 10,
      page: 1,
      search: searchController.text,
    ));
    response.when(success: (data) {
      originalProducts = data.products;
      filteredProducts = data.products;
      emit(SearchState.success(data));
    }, failure: (error) {
      emit(SearchState.error(error.message ?? ''));
    });
  }

  void setIsGridView(bool isGrid) {
    isGridView = isGrid;
    emit(SearchState.setIsGridView(isGrid));
  }

  void applyFilters(Map<String, String?> filters) {
    selectedFilters = filters;

    // If no filters are selected, show all products
    if (filters.values.every((value) => value == null)) {
      filteredProducts = originalProducts;
      emit(SearchState.applyFilters(selectedFilters));
      return;
    }

    // Filter the products based on selected filters
    filteredProducts = originalProducts.where((product) {
      bool categoryMatch = filters["category"] == null ||
          product.subCategories.any((cat) => cat.name == filters["category"]);

      bool occasionMatch = filters["occasion"] == null ||
          (product.occasions.isNotEmpty &&
              product.occasions.any((occ) => occ.name == filters["occasion"]));

      bool recipientMatch = filters["recipient"] == null ||
          (product.recipients.isNotEmpty &&
              product.recipients
                  .any((rec) => rec.name == filters["recipient"]));

      bool colorMatch = filters["color"] == null ||
          (product.colors.isNotEmpty &&
              product.colors.any((col) => col.name == filters["color"]));

      return categoryMatch && occasionMatch && recipientMatch && colorMatch;
    }).toList();
    emit(SearchState.applyFilters(selectedFilters));
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
}
