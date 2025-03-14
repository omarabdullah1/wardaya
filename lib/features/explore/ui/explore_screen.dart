import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/routing/routes.dart';
import 'package:wardaya/core/theming/colors.dart';

import '../../../core/assets/assets.dart';
import '../../../core/helpers/dummy_vars.dart';
import '../../home/ui/widgets/category_progress_scroll.dart';
import 'widgets/explore_card_item.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.offWhite,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          context.el.exploreScreenTitle,
          style: GoogleFonts.ebGaramond(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w400,
            fontSize: 37.0.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make the AppBar transparent
        elevation: 0, // Remove AppBar shadow
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSearchBox(context),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ExploreCardItem(
                      imageUrl:
                          'https://s3-alpha-sig.figma.com/img/8e3e/9429/5f9afb33f407be39848aa2053e8f09bc?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=X5~lhyoouM3Jy0awOt~p0N2sY2agbolhlbp1Mux25iZgVjcF0kYkpKS5rMfmLve2khXMiIhiSG9tXqvSFlzc55wk6-VymbYXh3PmDSW-rB0tS7Uzg6349logsqj57~lNmGuOeCKF9Hz2IrxHN2zX0U~-50pe9nolHyeGd1S-n5OhbCYc~SIvZSDgLSPSdygF2ENrIgJj-ydNkWvl2bTuREtTLkJ631e86OyJFaA6bBgWK1wSpMDGko5vMZQXYKeLtTcvHs0BJy6uKcYPjXONYM3ZCoSGbm7EE2AchwPkgfv87AYL57NGNG~Dw6L~gx6kDIwwsJi~r5L8rs~Vtao6Qw__',
                      lable: context.el.exploreCardMoments,
                      onTap: () {
                        context.pushNamed(
                          Routes.momentsScreen,
                          arguments: context,
                        );
                      },
                    ),
                    const Spacer(),
                    ExploreCardItem(
                      imageUrl:
                          'https://s3-alpha-sig.figma.com/img/18dc/f83a/beb6a599c1c021e02d83dbbbbd0ea135?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=l4B7WhxNeG2VUTv-juNjMGiFxWhjbHy0~UxktKCKBIMfyh7p258zDIxE1ljehsH1ytYYCfUZVTkGt9qRbsXZfIDhypfAvLL0Ww1JFaa1S4E8s2KW~5R4~KBsfSi8epMOz1n3RO5BzVsNi8cZnJNQCFrv75OiCkR2C8RkT6IewTjiuxz1OFeAyFi1OgIeFZRvQa8IwEoOG9e9T7iflb1u4rmfmkmV9AbbpT7crmk7WkYrEru44CzFp-X0gkIgFQckLUI0QXG9~zQMLcEEXj9I7EibtHj3q8QmYXRHahtnl1lkne-5Hi911SFZDpSJkXKoIB-xGjxbA3BzXkYqnbNUkg__',
                      lable: context.el.exploreCardRecipients,
                      onTap: () {
                        context.pushNamed(
                          Routes.recipientsScreen,
                          arguments: context,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildCategoryButton(
                  text: context.el.exploreCategoryFlowersPlants,
                  imagePath: Assets.of(context).images.flowersAndPlants_png,
                  onTap: () {
                    context.pushNamed(
                      Routes.flowersPlantsScreen,
                      arguments: context,
                    );
                  },
                ),
                const SizedBox(height: 10),
                _buildCategoryButton(
                  text: context.el.exploreCategoryFlowersGifts,
                  imagePath: Assets.of(context).images.flowersAndGifts_png,
                  onTap: () {
                    context.pushNamed(
                      Routes.flowersGiftsScreen,
                      arguments: context,
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCategoryCard(
                        imageUrl:
                            'https://s3-alpha-sig.figma.com/img/3c72/dafa/f6a7554e169094afc9930b29928dcf6a?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=Bv9xtf8S7H~h1inrrSYPGzeAOmapN~WBJzwPGMaYSA8STI70bXnN2TzXc31H3wqHGdtapwoVIuSN1B8GTmebYLwGCVbVflnTYIpsNFTxMFozEs5Aho7zikfp86lif8PWpFMYkYqmeHce92gQPiJE3Iiw0~Y1LG1Ny1KsyLkQ0Q6pjEUGNeY8gTrFaMfsbwfjHnZLDCvDPgBramwPzgazxVFYQZBboGYEC2NIeTn9cjz46CZZAycwlZvmadO0wAQO4sFNKIUbESj9MA32lFhojPK60wJAVcCDzLh41j3UpbuH0sNeqn9O12cvsP9A8RFFC4rqrYjQ8mxAvm2zncF6NQ__',
                        label: context.el.exploreCategoryExpressDelivery,
                        context: context,
                      ),
                      _buildCategoryCard(
                        imageUrl:
                            'https://s3-alpha-sig.figma.com/img/f60e/e0fa/aec08996e634c5a4b34f2465507dc91e?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=sEQZ4IZ0XMxPf1pZ~8bAcGMhPC59SPvDn69mZuZHQuPSf~-AZzBQxwBajOiGJbPdQ2a4OE7hxa9wNs773EKbnbwEXTnAQ1x8oSWsjVSVOCFAGUrNi4KXRxG-5KZXBhn8ed7it~4CBO8Wf8~P6Y21YU5cesOQuPJQ9ak14Y9RbuJrEuyLLxtzo4W56~JUCuCT7WJ9ANWEycSO6I79Q6uWXZ9PZaF89cnvxR0OeGOSvc~Ls87g1cx1Fhobn7UnwziL~MpasSFZBPAEV6hpFC-brln6cMHAPymoD4O5xjGh-K-Co3vDmjQbzpzxol7qhwabukd97jUpIkp2zpZEISwOgg__',
                        label: context.el.exploreCategoryFloralSubscription,
                        context: context,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.el.exploreBrandsYoullLove,
                      style: GoogleFonts.ebGaramond(
                        color: ColorsManager.mainRose,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    CategoryProgressScroll(
                      categoriesImages: brandsCategoriesImages,
                      titles: brandsTitles,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBox(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.searchScreen);
      },
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 2.0,
        child: Container(
          height: 50.0.h,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: ColorsManager.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.search,
                color: ColorsManager.mainRose,
              ),
              SizedBox(width: 8.w),
              Text(
                context.el.exploreSearchHint,
                style: GoogleFonts.inter(
                  color: ColorsManager.lightGrey,
                  fontWeight: FontWeight.w400,
                  fontSize: 13.0.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton({
    required String text,
    required String imagePath,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorsManager.mainRose.withAlpha(25),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25.w,
            vertical: 10.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.mainRose,
                ),
              ),
              Image.asset(
                imagePath,
                height: 60.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String imageUrl,
    required String label,
    required BuildContext context,
  }) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            colorBlendMode: BlendMode.srcATop,
            color: Colors.black12,
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: 165.w,
            height: 110.h,
            placeholder: (context, url) => _buildShadedPlaceholder(context),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.ebGaramond(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w400,
            fontSize: 21.0.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildShadedPlaceholder(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black, Colors.black],
          stops: [0.0, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.darken,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.withAlpha(51),
        ),
      ),
    );
  }
}
