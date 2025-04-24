import 'dart:developer';

import 'package:wardaya/features/my_orders/data/models/my_orders_response.dart';
import 'package:wardaya/features/my_orders/data/repos/my_orders_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  final MyOrdersRepo _repository;
  bool isLoadingMore = false;
  bool hasMorePages = true;
  int currentPage = 1;
  String? currentSearch;
  List<Order> allOrders = [];

  MyOrdersCubit(this._repository) : super(const MyOrdersState.initial());

  Future<void> getOrders({String? search}) async {
    currentSearch = search;
    currentPage = 1;
    allOrders = [];
    hasMorePages = true;

    emit(const MyOrdersState.loading());
    try {
      final response = await _repository.getMyOrders(
        limit: 10,
        page: currentPage,
        search: search,
      );

      response.when(
        success: (MyOrdersResponse data) {
          allOrders = data.orders;
          hasMorePages = currentPage < data.totalPages;
          log('Successfully received orders data with ${data.totalOrders} items');
          emit(MyOrdersState.success(data));
        },
        failure: (error) {
          log('Error fetching orders data: ${error.message}');
          emit(MyOrdersState.error(
              error.message ?? 'Failed to fetch orders data'));
        },
      );
    } catch (e, stackTrace) {
      log('orders unexpected error: $e', stackTrace: stackTrace);
      emit(
          MyOrdersState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> loadMoreOrders() async {
    if (!hasMorePages || isLoadingMore) return;

    isLoadingMore = true;
    currentPage++;

    try {
      final response = await _repository.getMyOrders(
        limit: 10,
        page: currentPage,
        search: currentSearch,
      );

      response.when(
        success: (MyOrdersResponse data) {
          allOrders.addAll(data.orders);
          hasMorePages = currentPage < data.totalPages;
          emit(MyOrdersState.success(MyOrdersResponse(
            orders: allOrders,
            page: data.page,
            limit: data.limit,
            totalOrders: data.totalOrders,
            totalPages: data.totalPages,
          )));
        },
        failure: (error) {
          currentPage--;
          emit(MyOrdersState.error(
              error.message ?? 'Failed to load more orders'));
        },
      );
    } catch (e) {
      currentPage--;
      emit(const MyOrdersState.error('Failed to load more orders'));
    } finally {
      isLoadingMore = false;
    }
  }
}
