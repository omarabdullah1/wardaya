// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:wardaya/core/assets/assets.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/search/data/models/search_response.dart';
import 'package:wardaya/features/search/logic/cubit/search_cubit.dart';

import '../../../../core/routing/router_imports.dart';
import '../../../search/data/models/search_response.dart' as searchModels;
import '../../../search/logic/cubit/search_state.dart';

class MakeItPerfectSection extends StatefulWidget {
  final String catID;
  const MakeItPerfectSection({
    super.key,
    required this.catID,
  });

  @override
  State<MakeItPerfectSection> createState() => _MakeItPerfectSectionState();
}

class _MakeItPerfectSectionState extends State<MakeItPerfectSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Dummy products for loading state
  List<searchModels.Product> get _dummyProducts => List.generate(
        8,
        (index) => searchModels.Product(
          id: index.toString(),
          title: 'Loading Product...',
          description: 'Loading description...',
          price: searchModels.Price(total: 0, currency: 'SAR'),
          images: ['assets/images/placeholder.png'],
          sku: 'SKU$index',
          productType: 'flower',
          categories: [],
          subCategories: [],
          expressDelivery: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          version: 1,
          bundleItems: [],
          bundleTypes: [],
          colors: [],
          freeDelivery: false,
          isBundle: false,
          occasions: [],
          premiumFlowers: false,
          productTypes: [],
          recipients: [],
          components: [],
          menuItems: [],
          subMenuItems: [],
        ),
      );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<SearchCubit>()
            ..emitSearchStates(
              filterCategory: widget.catID,
            ),
        ),
        BlocProvider.value(
          value: context.read<LayoutCubit>(),
        ),
      ],
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final List<searchModels.Product> products = state is Loading
              ? _dummyProducts
              : (state is Success
                  ? state.response.products.cast<searchModels.Product>()
                  : []);

          return Container(
            width: screenWidth * 0.9.w,
            height: 600.h,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorsManager.lightGrey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.of(context).svgs.ballons_svg,
                      height: 30.h,
                    ),
                    SizedBox(width: 11.w),
                    Text(
                      context.el.makeItPerfect,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.0.sp,
                        color: ColorsManager.mainRose,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                TabBar(
                  controller: _tabController,
                  indicatorColor: ColorsManager.mainRose,
                  labelColor: ColorsManager.mainRose,
                  unselectedLabelColor: ColorsManager.lighterLightGrey,
                  dividerColor: ColorsManager.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0.sp,
                  ),
                  tabs: [
                    Tab(text: context.el.recommendedTab),
                  ],
                ),
                SizedBox(
                  height: 400.h,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Skeletonizer(
                        enabled: state is Loading,
                        child: _buildProductGrid(context, products),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.0.h,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: OutlinedButton(
                            onPressed: () async {
                              context.read<LayoutCubit>();
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(140.w, 45.h),
                              side: const BorderSide(
                                color: ColorsManager.mainRose,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Continue Shopping',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.mainRose,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: ElevatedButton(
                            onPressed: () async {
                              context.read<LayoutCubit>();
                              await Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                Routes.homeLayout,
                                (route) => false,
                                arguments: {'initialIndex': 2},
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(140.w, 45.h),
                              backgroundColor: ColorsManager.mainRose,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'View Cart',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(
      BuildContext context, List<searchModels.Product> products) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.w,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductItem(context, products[index]);
      },
    );
  }

  Widget _buildProductItem(BuildContext context, searchModels.Product product) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.productDetailsScreen,
          arguments: {
            'extraArgs': Product(
              id: product.id,
              title: product.title,
              description: product.description,
              price: product.price,
              images: product.images,
              sku: product.sku,
              productType: product.productType,
              categories: product.categories,
              subCategories: product.subCategories,
              expressDelivery: product.expressDelivery,
              createdAt: product.createdAt,
              updatedAt: product.updatedAt,
              version: product.version,
              bundleItems: product.bundleItems,
              bundleTypes: product.bundleTypes,
              colors: product.colors,
              freeDelivery: product.freeDelivery,
              isBundle: product.isBundle,
              occasions: product.occasions,
              premiumFlowers: product.premiumFlowers,
              productTypes: product.productTypes,
              recipients: product.recipients,
              components: product.components,
              menuItems: product.menuItems,
              subMenuItems: product.subMenuItems,
            ),
          },
        );
      },
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorsManager.lightGrey,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.lightGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _buildProductImage(context, product),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.0.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: '${context.el.currencySar} ',
                      style: GoogleFonts.inter(
                        color: ColorsManager.mainRose,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0.sp,
                      ),
                      children: [
                        TextSpan(
                          text: product.price.total.toString(),
                          style: GoogleFonts.inter(
                            color: ColorsManager.mainRose,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    product.title,
                    style: GoogleFonts.inter(
                      color: ColorsManager.mainRose,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(
      BuildContext context, searchModels.Product product) {
    if (product.images.isEmpty) {
      return Center(
        child: SvgPicture.asset(
          Assets.of(context).svgs.small_logo_svg,
          height: 80.h,
          width: 80.w,
        ),
      );
    }

    String imageUrl = product.images.first;
    String finalUrl =
        imageUrl.startsWith('http') || imageUrl.startsWith('https')
            ? imageUrl
            : 'https://wecareroot.ddns.net:5100$imageUrl';

    return CachedNetworkImage(
      imageUrl: finalUrl,
      fit: BoxFit.contain,
      placeholder: (context, url) => Center(
        child: SvgPicture.asset(
          Assets.of(context).svgs.small_logo_svg,
          height: 80.h,
          width: 80.w,
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: SvgPicture.asset(
          Assets.of(context).svgs.small_logo_svg,
          height: 80.h,
          width: 80.w,
        ),
      ),
    );
  }
}
