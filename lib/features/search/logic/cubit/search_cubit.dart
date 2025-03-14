import 'package:wardaya/features/search/data/models/search_request_body.dart';
import 'package:wardaya/features/search/data/repos/search_repo.dart';

import '../../../../core/routing/router_inports.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _searchRepo;
  SearchCubit(this._searchRepo) : super(const SearchState.initial());

  TextEditingController searchController = TextEditingController();

  void emitSearchStates() async {
    emit(const SearchState.loading());
    final response = await _searchRepo.search(SearchRequestBody(
      limit: 10,
      page: 1,
      search: searchController.text,
    ));
    response.when(success: (data) {
      emit(SearchState.success(data));
    }, failure: (error) {
      emit(SearchState.error(error.message ?? ''));
    });
  }
}
