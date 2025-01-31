import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/helpers/extensions.dart';

class CategoryProgressScroll extends StatefulWidget {
  final List<String> categoriesImages;
  final List<String> titles;
  const CategoryProgressScroll({
    super.key,
    required this.categoriesImages,
    required this.titles,
  });

  @override
  State<CategoryProgressScroll> createState() => _CategoryProgressScrollState();
}

class _CategoryProgressScrollState extends State<CategoryProgressScroll> {
  final ScrollController _scrollController = ScrollController();

  double _scrollProgress = 0.0;
  double _itemWidth = 0.0; // Width of a single category item
  int _visibleItemsCount = 0; // Number of fully visible items
  final GlobalKey _itemKey = GlobalKey(); // Key to get item width

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollProgress);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateItemWidth();
      _calculateInitialProgress();
    });
  }

  void _calculateItemWidth() {
    if (_itemKey.currentContext != null) {
      final renderBox =
          _itemKey.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        _itemWidth = renderBox.size.width + 15; // Item width + margin
      });
    }
  }

  void _calculateInitialProgress() {
    if (_itemWidth > 0) {
      int visibleItems =
          (_scrollController.position.viewportDimension / _itemWidth).floor();
      setState(() {
        _visibleItemsCount = visibleItems;

        _scrollProgress = (_visibleItemsCount / widget.categoriesImages.length)
                .clamp(0.0, 1.0) *
            2.5;
      });
    }
  }

  void _updateScrollProgress() {
    if (_itemWidth > 0) {
      int visibleItems =
          (_scrollController.position.viewportDimension / _itemWidth).floor();
      final visibleItemsFromStart =
          (_scrollController.offset / _itemWidth).floor();

      setState(() {
        _visibleItemsCount = (visibleItems + visibleItemsFromStart)
            .clamp(0, widget.categoriesImages.length);
        _scrollProgress = (_visibleItemsCount / widget.categoriesImages.length)
                .clamp(0.0, 1.0) *
            2.5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final halfLength = (widget.categoriesImages.length ~/ 2) + 1;

    return Column(
      children: [
        SizedBox(
          height: context.pOH(20).h,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: Container(
              margin: const EdgeInsetsDirectional.only(start: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      halfLength,
                      (index) => _buildCategoryItem(
                        index: index,
                        title: widget.titles[index],
                        imagePath: widget.categoriesImages[index],
                        context: context,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      widget.categoriesImages.length - halfLength,
                      (index) => _buildCategoryItem(
                        key: index == 0 ? _itemKey : null,
                        index: index + halfLength,
                        title: widget.titles[index + halfLength],
                        imagePath: widget.categoriesImages[index + halfLength],
                        context: context,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 18.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.pOH(3).w),
          child: LinearProgressIndicator(
            value: _scrollProgress,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff074E59)),
            minHeight: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(
      {Key? key,
      required int index,
      required String title,
      required String imagePath,
      required BuildContext context}) {
    return Container(
      key: key, // Assign the key to the first item
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            width: imagePath.isNullOrEmpty()
                ? context.pOW(28).w
                : context.pOW(20).w,
            height:
                imagePath.isNullOrEmpty() ? context.pOH(6).h : context.pOH(7).h,
            decoration: imagePath.isNullOrEmpty()
                ? const BoxDecoration(
                    shape: BoxShape.rectangle, color: Color(0xffF0E9E0))
                : BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          SizedBox(height: 5.h),
          Text(
            title,
            style: GoogleFonts.inter(
              color: const Color(0xff074E59),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
