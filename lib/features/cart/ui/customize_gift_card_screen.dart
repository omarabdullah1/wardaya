import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/widgets/loading_widget.dart';
import '../logic/cubit/cart_cubit.dart';
import '../logic/giftCards/gift_cards_cubit.dart';
import '../logic/giftCards/gift_cards_state.dart';
import 'widgets/add_message_tab.dart';
import 'widgets/preview_bottom_sheet.dart';
import 'widgets/select_card_tab.dart';

class CustomizeGiftCardScreen extends StatefulWidget {
  final int initialTabIndex;
  final BuildContext parentContext;
  const CustomizeGiftCardScreen({
    super.key,
    this.initialTabIndex = 0,
    required this.parentContext,
  });

  @override
  State<CustomizeGiftCardScreen> createState() =>
      _CustomizeGiftCardScreenState();
}

class _CustomizeGiftCardScreenState extends State<CustomizeGiftCardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  // Controllers for message fields
  bool isSignatureSelected = false;
  int selectedCardIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
    _pageController = PageController(initialPage: 0);
    final cartCubit = context.read<CartCubit>();

    // Initialize from CartCubit values.
    selectedCardIndex = cartCubit.selectedCardIndex;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();

    super.dispose();
  }

  void _saveAndContinue() {
    final cartCubit = widget.parentContext.read<CartCubit>();
    cartCubit.setSelectedCard(
      selectedCardIndex,
    );
    cartCubit.setMessageData(
      to: cartCubit.toController.text,
      message: cartCubit.messageController.text,
      from: cartCubit.fromController.text,
    );
    Navigator.pop(context);
  }

  void _showPreview() {
    final cartCubit = widget.parentContext.read<CartCubit>();
    final giftCard = widget.parentContext.read<GiftCardsCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: cartCubit,
        child: BlocProvider.value(
          value: giftCard,
          child: SizedBox(
            height: 450.h,
            child: PreviewBottomSheet(
              selectedCardIndex: selectedCardIndex,
              cartContext: context,
              pageController: _pageController,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: AppBar(
        backgroundColor: ColorsManager.white,
        title: Text(
          context.el.customizeGiftCard,
          style: GoogleFonts.inter(
            color: ColorsManager.mainRose,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: ColorsManager.mainRose,
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: ColorsManager.mainRose,
          labelColor: ColorsManager.mainRose,
          dividerColor: ColorsManager.transparent,
          unselectedLabelColor: ColorsManager.lighterLightGrey,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
          tabs: [
            Tab(text: context.el.selectCard),
            Tab(text: context.el.addMessage),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          color: ColorsManager.offWhite,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TabBarView(
              controller: _tabController,
              children: [
                // Gift cards builder with loading and error states
                BlocConsumer<GiftCardsCubit, GiftCardsState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      loading: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const LoadingWidget(
                              loadingState: true,
                            ),
                          );
                        });
                      },
                      loaded: (_) {
                        // Navigator.of(context).pop();
                      },
                      error: (message) {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              message,
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      orElse: () {},
                    );
                  },
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () => Skeletonizer(
                        enabled: true,
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Container(
                                height: 300.h,
                                decoration: BoxDecoration(
                                  color: ColorsManager.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      loaded: (giftCards) => SelectCardTab(
                        selectedCardIndex: selectedCardIndex,
                        onCardSelected: (index) {
                          // Update local state first
                          setState(() => selectedCardIndex = index);

                          // Don't call setSelectedCard here - we'll save all changes when "Save and Continue" is pressed
                          // This was causing the screen to close prematurely
                        },
                        giftCards: giftCards,
                      ),
                      error: (message) => Center(
                        child: Text(
                          message,
                          style: GoogleFonts.inter(
                            color: ColorsManager.mainRose,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Extracted AddMessageTab widget:
                AddMessageTab(
                  isSignatureSelected: isSignatureSelected,
                  onSignatureToggle: () => setState(
                      () => isSignatureSelected = !isSignatureSelected),
                  cartContext: widget.parentContext,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: ColorsManager.white,
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.white,
                side: const BorderSide(color: ColorsManager.mainRose),
                fixedSize: Size(context.screenWidth * 0.45, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: _showPreview,
              child: FittedBox(
                child: Text(
                  context.el.preview,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: ColorsManager.mainRose,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainRose,
                fixedSize: Size(context.screenWidth * 0.45, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: _saveAndContinue,
              child: FittedBox(
                child: Text(
                  context.el.saveAndContinue,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    color: ColorsManager.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
