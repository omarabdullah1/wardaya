import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';

typedef ItemBuilder<T> = Widget Function(
    BuildContext context, T item, int index);
typedef FetchMoreItemsCallback<T> = Future<List<T>> Function(
    int page, int pageSize);

class PaginatedListView<T> extends StatefulWidget {
  final List<T> items;
  final ItemBuilder<T> itemBuilder;
  final FetchMoreItemsCallback<T> onFetchMoreItems;
  final int pageSize;
  final int totalItemsCount;
  final bool isGrid;
  final int gridCrossAxisCount;
  final double gridMainAxisSpacing;
  final double gridCrossAxisSpacing;
  final Widget? separatorBuilder;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  const PaginatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onFetchMoreItems,
    this.pageSize = 10,
    required this.totalItemsCount,
    this.isGrid = false,
    this.gridCrossAxisCount = 2,
    this.gridMainAxisSpacing = 10,
    this.gridCrossAxisSpacing = 10,
    this.separatorBuilder,
    this.padding,
    this.physics,
    this.scrollController,
    this.emptyWidget,
    this.loadingWidget,
    this.errorWidget,
  });

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  late ScrollController _scrollController;
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasReachedMax = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);

    // Check if we already have all items
    if (widget.items.length >= widget.totalItemsCount) {
      _hasReachedMax = true;
    }
  }

  @override
  void didUpdateWidget(PaginatedListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reset pagination when items list is reset (like after applying filters)
    if (oldWidget.items.isNotEmpty &&
        widget.items.isNotEmpty &&
        widget.items.length <= widget.pageSize &&
        oldWidget.items != widget.items) {
      log('Items list was reset, resetting pagination');
      _currentPage = 1;
      _hasReachedMax = false;
      _hasError = false;
    }

    // Update hasReachedMax if we have all items
    if (widget.items.length >= widget.totalItemsCount) {
      _hasReachedMax = true;
    }
  }

  void _onScroll() {
    if (_isLoading || _hasReachedMax || _hasError) return;

    // Load more when user scrolls past 70% of the list for smoother experience
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.7) {
      _fetchMoreItems();
    }
  }

  Future<void> _fetchMoreItems() async {
    if (_isLoading || _hasReachedMax) return;

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      log('Fetching page ${_currentPage + 1}');

      final newItems = await widget.onFetchMoreItems(
        _currentPage + 1,
        widget.pageSize,
      );

      // Calculate total pages
      final totalPages = (widget.totalItemsCount / widget.pageSize).ceil();
      log('Total pages: $totalPages, Current page: ${_currentPage + 1}, Items count: ${newItems.length}');

      if (newItems.isEmpty || _currentPage + 1 >= totalPages) {
        setState(() {
          _hasReachedMax = true;
        });
        log('Reached maximum pages');
      } else {
        setState(() {
          _currentPage++;
        });
        log('Advanced to page $_currentPage');
      }
    } catch (error) {
      log('Error fetching more items: $error');
      setState(() {
        _hasError = true;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // Only dispose the controller if we created it
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return widget.emptyWidget ??
          const Center(
            child: Text('No items found'),
          );
    }

    return Stack(
      children: [
        widget.isGrid ? _buildGridView() : _buildListView(),
        if (_isLoading)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: widget.loadingWidget ??
                Container(
                  padding: EdgeInsets.all(10.r),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: ColorsManager.mainRose,
                  ),
                ),
          ),
        if (_hasError)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: widget.errorWidget ??
                Container(
                  padding: EdgeInsets.all(10.r),
                  color: Colors.red.withAlpha((0.8 * 255).toInt()),
                  child: Text(
                    'Error loading more items. Tap to retry.',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
          ),
      ],
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      controller: _scrollController,
      padding: widget.padding,
      physics: widget.physics,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.gridCrossAxisCount,
        mainAxisSpacing: widget.gridMainAxisSpacing,
        crossAxisSpacing: widget.gridCrossAxisSpacing,
      ),
      itemCount: widget.items.length,
      itemBuilder: (context, index) =>
          widget.itemBuilder(context, widget.items[index], index),
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      controller: _scrollController,
      padding: widget.padding,
      physics: widget.physics,
      itemCount: widget.items.length,
      separatorBuilder: (context, index) =>
          widget.separatorBuilder ?? SizedBox(height: 10.h),
      itemBuilder: (context, index) =>
          widget.itemBuilder(context, widget.items[index], index),
    );
  }
}
