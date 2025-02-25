import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/blocs/general/cubit/general_cubit.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import '../../../core/helpers/dummy_vars.dart';
import '../../../core/routing/routes.dart';
import '../../cart/logic/cubit/cart_cubit.dart';

class CategoryScreen extends StatefulWidget {
  final String momentTitle;
  const CategoryScreen({super.key, required this.momentTitle});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<Product> products = allProducts;
  bool isGridView = true;
  Map<String, String?> _selectedFilters = {};
  Map<String, String?> _tempFilters = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.mainRose,
          ), // Back button
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          widget.momentTitle,
          style: GoogleFonts.ebGaramond(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w400,
            fontSize: 30.0.sp,
          ),
        ),
        backgroundColor: ColorsManager.offWhite, // Make the AppBar transparent
        elevation: 0, // Remove AppBar shadow
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: _buildFilterChips(),
            ),
            const Divider(
              color: ColorsManager.lightGrey,
              thickness: 1.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: _buildProductCount(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: _buildProductView(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          _showFilterBottomSheet();
        },
        child: Container(
          width: context.pOW(30).w,
          decoration: BoxDecoration(
            color: ColorsManager.mainRose,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: context.watch<GeneralCubit>().lang == 'ar'
                  ? [
                      Text(
                        context.el.filtersTitle,
                        style: GoogleFonts.inter(
                          color: ColorsManager.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0.sp,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        Assets.of(context).svgs.filter_svg,
                        colorFilter: const ColorFilter.mode(
                          ColorsManager.white,
                          BlendMode.srcIn,
                        ),
                        height: 16.0.h,
                      ),
                    ]
                  : [
                      SvgPicture.asset(
                        Assets.of(context).svgs.filter_svg,
                        colorFilter: const ColorFilter.mode(
                          ColorsManager.white,
                          BlendMode.srcIn,
                        ),
                        height: 16.0.h,
                      ),
                      const Spacer(),
                      Text(
                        context.el.filtersTitle,
                        style: GoogleFonts.inter(
                          color: ColorsManager.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0.sp,
                        ),
                      ),
                    ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 50.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildTitleChip(), // This is our modified chip
          _buildFilterChip("Cakes", "category"),
          _buildFilterChip("Flowers", "category"),
          _buildFilterChip("Sweets & Chocolate", "category"),
          _buildFilterChip("Jewelry", "category"),
          _buildFilterChip("Perfumes", "category"),
          _buildFilterChip("Vouchers", "category"),
        ],
      ),
    );
  }

  Widget _buildTitleChip() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: ChoiceChip(
          backgroundColor: ColorsManager.white,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: ColorsManager.transparent),
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
          elevation: 4,
          avatar: Padding(
            padding: EdgeInsetsDirectional.only(end: 1.0.w),
            child: Container(
              height: 35.0.h,
              decoration: const BoxDecoration(
                color: ColorsManager.grey,
                shape: BoxShape.circle,
                // image: DecorationImage(
                //   image: AssetImage(
                //     Assets.of(context).images.cake,
                //   ),
                //  fit: BoxFit.cover,
                // ),
              ),
            ),
          ),
          showCheckmark: false,
          label: Text(
            widget.momentTitle,
            style: GoogleFonts.inter(
              color: ColorsManager.mainRose,
              fontWeight: FontWeight.w400,
              fontSize: 12.0.sp,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 2.h,
          ),
          labelPadding: EdgeInsetsDirectional.only(start: 12.0.w),
          selected: _selectedFilters.isEmpty, // Select if no filters are active
          onSelected: (bool selected) {
            if (selected) {
              setState(() {
                _selectedFilters.clear();
                products = allProducts;
              });
            }
          }),
    );
  }

  Widget _buildFilterChip(String label, String filterType) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: ChoiceChip(
          backgroundColor: ColorsManager.white,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: ColorsManager.transparent),
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
          elevation: 4,
          avatar: Padding(
            padding: EdgeInsetsDirectional.only(end: 1.0.w),
            child: Container(
              height: 35.0.h,
              decoration: const BoxDecoration(
                color: ColorsManager.grey,
                shape: BoxShape.circle,
                // image: DecorationImage(
                //   image: AssetImage(
                //     Assets.of(context).images.cake,
                //   ),
                //  fit: BoxFit.cover,
                // ),
              ),
            ),
          ),
          showCheckmark: false,
          label: Text(
            label,
            style: GoogleFonts.inter(
              color: ColorsManager.mainRose,
              fontWeight: FontWeight.w400,
              fontSize: 12.0.sp,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 2.h,
          ),
          labelPadding: EdgeInsetsDirectional.only(start: 12.0.w),
          selected: _selectedFilters[filterType] == label,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedFilters[filterType] = label;
              } else {
                _selectedFilters[filterType] = null;
              }
              _applyFilters();
            });
          }),
    );
  }

  void _applyFilters() {
    products = allProducts.where((product) {
      bool categoryMatch = true;
      bool occasionMatch = true;
      bool recipientMatch = true;
      bool colorMatch = true;
      bool priceMatch = true;

      if (_selectedFilters["category"] != null &&
          _selectedFilters["category"] != "All") {
        categoryMatch = product.category == _selectedFilters["category"];
      }

      if (_selectedFilters["occasion"] != null &&
          _selectedFilters["occasion"] != "All") {
        occasionMatch = product.occasion == _selectedFilters["occasion"];
      }

      if (_selectedFilters["recipient"] != null &&
          _selectedFilters["recipient"] != "All") {
        recipientMatch = product.recipient == _selectedFilters["recipient"];
      }
      if (_selectedFilters["color"] != null &&
          _selectedFilters["color"] != "All") {
        colorMatch = product.color == _selectedFilters["color"];
      }

      return categoryMatch &&
          occasionMatch &&
          recipientMatch &&
          colorMatch &&
          priceMatch;
    }).toList();
  }

  Widget _buildProductCount() {
    final String showProductsNumberText = context.el.showProductsPart1 +
        products.length.toString() +
        context.el.showProductsPart2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            showProductsNumberText,
            style: GoogleFonts.inter(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w700,
              color: ColorsManager.mainRose,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorsManager.lightGrey,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 6.0.h),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isGridView = true;
                      });
                    },
                    child: isGridView
                        ? Container(
                            decoration: const BoxDecoration(
                              color: ColorsManager.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0.w, vertical: 6.0.h),
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.of(context).svgs.grid_svg,
                                  colorFilter: const ColorFilter.mode(
                                    ColorsManager.mainRose,
                                    BlendMode.srcIn,
                                  ),
                                  height: 14.0.h,
                                ),
                              ),
                            ),
                          )
                        : SvgPicture.asset(
                            Assets.of(context).svgs.grid_svg,
                            colorFilter: const ColorFilter.mode(
                              ColorsManager.mainRose,
                              BlendMode.srcIn,
                            ),
                            height: 14.0.h,
                          ),
                  ),
                  SizedBox(
                    width: 15.0.w,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isGridView = false;
                      });
                    },
                    child: !isGridView
                        ? Container(
                            decoration: const BoxDecoration(
                              color: ColorsManager.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0.w, vertical: 6.0.h),
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.of(context).svgs.tile_svg,
                                  colorFilter: const ColorFilter.mode(
                                    ColorsManager.mainRose,
                                    BlendMode.srcIn,
                                  ),
                                  height: 14.0.h,
                                ),
                              ),
                            ),
                          )
                        : SvgPicture.asset(
                            Assets.of(context).svgs.tile_svg,
                            colorFilter: const ColorFilter.mode(
                              ColorsManager.mainRose,
                              BlendMode.srcIn,
                            ),
                            height: 14.0.h,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductView() {
    return isGridView ? _buildProductGrid() : _buildProductList();
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.60,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {});
            context.pushNamedWithCubit(
              Routes.productDetailsScreen,
              context.read<CartCubit>(),
            );
          },
          child: _buildProductItem(products[index]),
        );
      },
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {});
              context.pushNamed(
                Routes.productDetailsScreen,
              );
            },
            child: _buildProductItem(products[index]),
          );
        });
  }

  Widget _buildProductItem(Product product) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !product.imageUrl.isNullOrEmpty()
              ? Image.asset(product.imageUrl,
                  height: isGridView ? 120.h : 200.h, fit: BoxFit.cover)
              : Container(
                  height: isGridView ? 120.h : 200.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.lightGrey,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "SAR ",
                    style: GoogleFonts.inter(
                      fontSize: 11.0.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.mainRose,
                    ),
                    children: [
                      TextSpan(
                        text: product.price.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.mainRose,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  product.name,
                  style: GoogleFonts.inter(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorsManager.mainRose,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    double currentSheetSize = 0.55;
    _tempFilters = Map.from(_selectedFilters);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: constraints.maxHeight * currentSheetSize),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DraggableScrollableSheet(
                  initialChildSize:
                      1.0, // Start at full size within the constrained box
                  minChildSize: 0.3,
                  maxChildSize: 1,
                  expand: true,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollUpdateNotification) {
                          if (notification.metrics.pixels > 0 &&
                              currentSheetSize < 1.0) {
                            setState(() {
                              currentSheetSize = 1.0;
                            });
                          }
                        }
                        return true;
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: ColorsManager.lighterGrey,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20)), // Rounded corners
                        ),
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min, // Important for correct sizing
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align to the start
                          children: [
                            Material(
                              elevation: 1.0,
                              shadowColor: ColorsManager.grey,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: ColorsManager.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              context.el.filtersTitle,
                                              style: GoogleFonts.ebGaramond(
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.w400,
                                                color: ColorsManager.mainRose,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () => context.pop(),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorsManager.lighterGrey,
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.close,
                                                color: ColorsManager.mainRose,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20), // Spacing after title
                            Expanded(
                              // Use Expanded to fill available space
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: SingleChildScrollView(
                                  // Use SingleChildScrollView if content might overflow
                                  child: Column(
                                    children: <Widget>[
                                      _buildBottomSheetFilter(
                                          context.el.categoryFilterTitle,
                                          "category",
                                          [
                                            "All",
                                            "Cakes",
                                            "Flowers",
                                            "Sweets & Chocolate",
                                            "Jewelry",
                                            "Perfumes",
                                            "Vouchers"
                                          ],
                                          setState),
                                      _buildBottomSheetFilter(
                                          context.el.occasionFilterTitle,
                                          "occasion",
                                          [
                                            "All",
                                            "Birthday",
                                            "Anniversary",
                                            "General"
                                          ],
                                          setState),
                                      _buildBottomSheetFilter(
                                          context.el.recipientFilterTitle,
                                          "recipient",
                                          [
                                            "All",
                                            "Adult",
                                            "Partner",
                                            "Child",
                                            "Parent",
                                            "Friend",
                                            "Any"
                                          ],
                                          setState),
                                      _buildBottomSheetFilter(
                                          context.el.colorFilterTitle,
                                          "color",
                                          [
                                            "All",
                                            "Red",
                                            "Brown",
                                            "Multi",
                                            "White",
                                            "Gold",
                                            "Silver",
                                            "None"
                                          ],
                                          setState),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20), // Spacing before button
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: _buildBottomSheetButton(setState),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        });
      },
    );
  }

  Widget _buildBottomSheetButton(StateSetter setModalState) {
    int filteredCount = _calculateFilteredCount();
    final String showFilteredNumberText = context.el.showProductsPart1 +
        filteredCount.toString() +
        context.el.showProductsPart2;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedFilters = Map.from(_tempFilters);
          _applyFilters();
        });
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.mainRose, // Set background color
        foregroundColor: Colors.white, // Set text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25), // Set rounded corners
        ),
        padding: const EdgeInsets.symmetric(vertical: 15), // Set padding
        textStyle: GoogleFonts.inter(
          fontSize: 16.0.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Center(child: Text(showFilteredNumberText)), // Center the text
    );
  }

  Widget _buildBottomSheetFilter(String title, String filterType,
      List<String> options, StateSetter setModalState) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ExpansionTile(
          iconColor: ColorsManager.mainRose,
          collapsedIconColor: ColorsManager.mainRose,
          backgroundColor: ColorsManager.white,
          title: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.w500,
              color: ColorsManager.mainRose,
            ),
          ),
          childrenPadding: const EdgeInsets.symmetric(
              horizontal: 20), // Add padding to the children
          expandedCrossAxisAlignment:
              CrossAxisAlignment.start, // Align children to start
          children: options
              .map(
                (option) => RadioListTile<String>(
                  controlAffinity: ListTileControlAffinity.trailing,
                  fillColor: WidgetStateProperty.all(ColorsManager.mainRose),
                  title: Text(
                    option,
                    style: GoogleFonts.inter(
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.normal,
                      color: ColorsManager.mainRose,
                    ),
                  ),
                  value: option,
                  groupValue: _tempFilters[filterType],
                  onChanged: (value) {
                    setModalState(() {
                      if (value == "All") {
                        _tempFilters[filterType] = null;
                      } else {
                        _tempFilters[filterType] = value;
                      }
                    });
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  int _calculateFilteredCount() {
    List<Product> filteredProducts = allProducts.where((product) {
      bool categoryMatch = true;
      bool occasionMatch = true;
      bool recipientMatch = true;
      bool colorMatch = true;
      bool priceMatch = true;

      if (_tempFilters["category"] != null &&
          _tempFilters["category"] != "All") {
        categoryMatch = product.category == _tempFilters["category"];
      }

      if (_tempFilters["occasion"] != null &&
          _tempFilters["occasion"] != "All") {
        occasionMatch = product.occasion == _tempFilters["occasion"];
      }

      if (_tempFilters["recipient"] != null &&
          _tempFilters["recipient"] != "All") {
        recipientMatch = product.recipient == _tempFilters["recipient"];
      }
      if (_tempFilters["color"] != null && _tempFilters["color"] != "All") {
        colorMatch = product.color == _tempFilters["color"];
      }

      return categoryMatch &&
          occasionMatch &&
          recipientMatch &&
          colorMatch &&
          priceMatch;
    }).toList();
    return filteredProducts.length;
  }
}
