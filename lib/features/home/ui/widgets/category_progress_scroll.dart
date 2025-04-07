import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/features/home/data/apis/home_api_constants.dart';

import '../../../../core/assets/assets.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';

class CategoryProgressScroll extends StatefulWidget {
  final List<String> categoriesImages;
  final List<String> titles;
  final bool isBackgroundColor;
  final List<String>? ids; // Add IDs for tracking
  final String?
      sourceType; // Add source type to differentiate between 'occasion' and 'category'

  const CategoryProgressScroll({
    super.key,
    required this.categoriesImages,
    required this.titles,
    required this.isBackgroundColor,
    this.ids, // Optional IDs list
    this.sourceType, // Optional source type
  });

  @override
  State<CategoryProgressScroll> createState() => _CategoryProgressScrollState();
}

class _CategoryProgressScrollState extends State<CategoryProgressScroll> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.2; // Start at 20% threshold
  final double _initialThreshold = 0.2; // 20% threshold

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollProgress);

    // Set initial progress after layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _scrollProgress = _initialThreshold;
      });
    });
  }

  void _updateScrollProgress() {
    if (_scrollController.hasClients &&
        _scrollController.position.maxScrollExtent > 0) {
      // Calculate the actual scroll progress
      double actualProgress =
          _scrollController.offset / _scrollController.position.maxScrollExtent;

      // Map the actual progress (0.0 to 1.0) to a range from initialThreshold to 1.0
      double mappedProgress =
          _initialThreshold + (actualProgress * (1.0 - _initialThreshold));

      setState(() {
        // Ensure progress is never below the threshold
        _scrollProgress = mappedProgress.clamp(_initialThreshold, 1.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          // Dynamic height calculation based on content and number of rows needed
          height: _calculateContainerHeight(),
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification) {
                _updateScrollProgress();
              }
              return false;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: widget.isBackgroundColor
                      ? _buildDynamicCircularLayout() // New dynamic layout method
                      : _buildRectangularLayout() // Layout for rectangular background (isBackgroundColor=false)
                  ),
            ),
          ),
        ),
        const VerticalSpace(height: 16),
        // Make the progress bar more visible
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Stack(
            children: [
              // Background track
              Container(
                height: 2.5.h,
                decoration: BoxDecoration(
                  color: ColorsManager.lightGrey,
                  borderRadius: BorderRadius.circular(1.5.h),
                ),
              ),
              // Progress indicator with minimum threshold
              FractionallySizedBox(
                widthFactor: _scrollProgress,
                child: Container(
                  height: 2.5.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.mainRose,
                    borderRadius: BorderRadius.circular(1.5.h),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Layout for rectangular items (brands, categories)
  Widget _buildRectangularLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First row
            Row(
              children:
                  _buildItemsForRow(0, widget.categoriesImages.length ~/ 2 + 1),
            ),
            const VerticalSpace(height: 15),
            // Second row
            Row(
              children: _buildItemsForRow(
                  widget.categoriesImages.length ~/ 2 + 1,
                  widget.categoriesImages.length),
            ),
          ],
        ),
        const HorizontalSpace(width: 32), // Ensure we can scroll
      ],
    );
  }

  List<Widget> _buildItemsForRow(int startIndex, int endIndex) {
    List<Widget> items = [];
    for (int i = startIndex; i < endIndex; i++) {
      if (i < widget.categoriesImages.length) {
        items.add(
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: _buildCategoryItem(
              index: i,
              title: widget.titles[i],
              imagePath: widget.categoriesImages[i],
              context: context,
              isBackgroundColor: widget.isBackgroundColor,
            ),
          ),
        );
      }
    }
    return items;
  }

  Widget _buildCategoryItem({
    Key? key,
    required int index,
    required String title,
    required String imagePath,
    required BuildContext context,
    required bool isBackgroundColor,
  }) {
    // Size for different types of items
    final double itemSize = isBackgroundColor
        ? 100.w // Increased circle items size from 80.w to 100.w
        : (index % 3 == 0)
            ? 80.w
            : (index % 2 == 0)
                ? 75.w
                : 80.w; // Variation for rectangular items

    final double fontSizeForText = isBackgroundColor ? 13.sp : 12.sp;

    // Get the ID for this item if available
    final String? itemId = widget.ids != null && index < widget.ids!.length
        ? widget.ids![index]
        : null;

    return InkWell(
      onTap: () {
        // Create arguments based on source type
        Map<String, dynamic> arguments = {'extraArgs': title};

        // Add different search parameters based on source
        if (widget.sourceType == 'occasion' && itemId != null) {
          arguments['occasionId'] = itemId;
        } else if (widget.sourceType == 'subCategory' && itemId != null) {
          arguments['subCategoryId'] = itemId;
        } else if (widget.sourceType == 'category' && itemId != null) {
          arguments['categoryId'] = itemId;
        } else if (widget.sourceType == 'recipient' && itemId != null) {
          arguments['recipientId'] = itemId;
        }

        context.pushNamed(
          Routes.categoryScreen,
          arguments: arguments,
        );
      },
      child: SizedBox(
        key: key,
        width: itemSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: itemSize,
              height: itemSize,
              decoration: imagePath.isNullOrEmpty()
                  ? BoxDecoration(
                      shape: isBackgroundColor
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      color: ColorsManager.mainRose.withAlpha(30),
                      borderRadius: !isBackgroundColor
                          ? const BorderRadius.all(Radius.circular(12.5))
                          : null,
                    )
                  : null,
              child: imagePath.isNullOrEmpty()
                  ? null
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(isBackgroundColor
                          ? 50.0
                          : 12.5), // Increased radius for circular items
                      child: CachedNetworkImage(
                        imageUrl:
                            HomeApiConstants.apiBaseUrlForImages + imagePath,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            color: ColorsManager.mainRose.withAlpha(30),
                            shape: isBackgroundColor
                                ? BoxShape.circle
                                : BoxShape.rectangle,
                            borderRadius: !isBackgroundColor
                                ? const BorderRadius.all(Radius.circular(12.5))
                                : null,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.of(context).svgs.small_logo_svg,
                              colorFilter: const ColorFilter.mode(
                                ColorsManager.mainRose,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            color: ColorsManager.mainRose.withAlpha(30),
                            shape: isBackgroundColor
                                ? BoxShape.circle
                                : BoxShape.rectangle,
                            borderRadius: !isBackgroundColor
                                ? const BorderRadius.all(Radius.circular(12.5))
                                : null,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: ColorsManager.mainRose,
                              strokeWidth: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            const VerticalSpace(height: 8), // Increased spacing
            if (!title.isNullOrEmpty())
              SizedBox(
                height: 22.h, // Increased height for text container
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: ColorsManager.mainRose,
                    fontSize: fontSizeForText, // Larger font for circular items
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // New method to determine if we need two rows based on item count
  bool _needsTwoRows(BuildContext context) {
    if (widget.isBackgroundColor) {
      // Simple rule: if 4 or fewer items, use one row
      return widget.categoriesImages.length > 4;
    } else {
      // For rectangular layout, always use two rows
      return true;
    }
  }

  // Dynamically calculate container height based on content
  double _calculateContainerHeight() {
    // For circular items (isBackgroundColor=true)
    if (widget.isBackgroundColor) {
      // Simple rule: if 4 or fewer items, use one row
      final needsTwoRows = widget.categoriesImages.length > 4;

      // Add extra padding for the text below the circles
      final itemHeight = 120.w; // Width equals height for circle items
      final textHeight = 22.h; // Text height
      final verticalSpacing =
          needsTwoRows ? 15.h : 0; // Spacing between rows if needed
      final verticalPadding = 8.h; // Top and bottom padding

      // Dynamic calculation based on content
      return needsTwoRows
          ? itemHeight * 2 +
              textHeight +
              verticalSpacing +
              verticalPadding // Two rows total height
          : itemHeight +
              textHeight +
              verticalPadding; // Single row total height
    } else {
      // For rectangular items, let's also make this dynamic
      final itemHeight = 80.w; // Base height for rectangular items
      final textHeight = 22.h;
      final verticalSpacing = 15.h; // Spacing between two rows
      final verticalPadding = 8.h;

      return (itemHeight * 2) + textHeight + verticalSpacing + verticalPadding;
    }
  }

  // New dynamic layout that chooses between one or two rows
  Widget _buildDynamicCircularLayout() {
    final needsTwoRows = _needsTwoRows(context);

    if (!needsTwoRows) {
      // Single row layout for small lists (4 or fewer items)
      return Row(
        children: List.generate(
          widget.categoriesImages.length,
          (index) => Padding(
            padding: EdgeInsets.only(right: 22.w),
            child: _buildCategoryItem(
              index: index,
              title: widget.titles[index],
              imagePath: widget.categoriesImages[index],
              context: context,
              isBackgroundColor: true,
            ),
          ),
        ),
      );
    } else {
      // Two-row layout for larger lists
      // Calculate item distribution based on list length
      final totalItems = widget.categoriesImages.length;
      int upperRowCount, lowerRowCount;

      // Check if the list can be evenly divided into two rows
      if (totalItems % 2 == 0) {
        // Even distribution for divisible by 2
        upperRowCount = totalItems ~/ 2;
        lowerRowCount = totalItems ~/ 2;
      } else {
        // For odd numbers, put one more item in the top row
        upperRowCount = (totalItems ~/ 2) + 1;
        lowerRowCount = totalItems ~/ 2;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First row (upper)
          Row(
            children: List.generate(
              upperRowCount,
              (index) => Padding(
                padding: EdgeInsets.only(right: 22.w),
                child: _buildCategoryItem(
                  index: index,
                  title: widget.titles[index],
                  imagePath: widget.categoriesImages[index],
                  context: context,
                  isBackgroundColor: true,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          // Second row (lower)
          if (lowerRowCount > 0)
            Row(
              children: List.generate(
                lowerRowCount,
                (index) {
                  final actualIndex = index + upperRowCount;
                  return Padding(
                    padding: EdgeInsets.only(right: 22.w),
                    child: _buildCategoryItem(
                      index: actualIndex,
                      title: widget.titles[actualIndex],
                      imagePath: widget.categoriesImages[actualIndex],
                      context: context,
                      isBackgroundColor: true,
                    ),
                  );
                },
              ),
            ),
        ],
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
