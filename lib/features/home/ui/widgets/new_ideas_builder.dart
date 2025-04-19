import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/routing/routes.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/features/home/data/apis/home_api_constants.dart';

import '../../../../core/assets/assets.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../data/models/home_new_ideas_response.dart';
import '../../logic/new_ideas/new_ideas_cubit.dart';
import '../../logic/new_ideas/new_ideas_state.dart';

class NewIdeasBuilder extends StatelessWidget {
  const NewIdeasBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewIdeasCubit, NewIdeasState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => _buildLoading(context),
          success: (newIdeas) => _buildSuccess(context, newIdeas),
          error: (message) => _buildError(context, message),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SizedBox(
        height: 300, // Adjust this based on your card height
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CardItem(
                imageUrl: Assets.of(context).images.delivery_png,
                title: context.el.discoverCardExpressDeliveryTitle,
                buttonText: context.el.discoverCardExpressDeliveryButton,
                onPressed: () {
                  // Navigate to category screen with express delivery parameter
                  context.pushNamed(
                    Routes.categoryScreen,
                    arguments: {
                      'extraArgs': 'Express Delivery',
                      'expressDelivery': true,
                    },
                  );
                },
                isAsset: true,
              ),
              const SizedBox(width: 10),
              CardItem(
                imageUrl: Assets.of(context).images.subscription_png,
                title: context.el.discoverCardWeeklySurpriseTitle,
                buttonText: context.el.discoverCardWeeklySurpriseButton,
                isAsset: true,
                onPressed: () {
                  context.pushNamed(
                    Routes.susbcriptionsScreen,
                  );
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<HomeNewIdeasItem> newIdeas) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.el.discoverNewIdeasTitle,
            style: GoogleFonts.ebGaramond(
              fontSize: 32.sp,
              fontWeight: FontWeight.w400,
              color: ColorsManager.mainRose,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Static cards from discover ideas
                  CardItem(
                    imageUrl: Assets.of(context).images.delivery_png,
                    title: context.el.discoverCardExpressDeliveryTitle,
                    buttonText: context.el.discoverCardExpressDeliveryButton,
                    onPressed: () {
                      context.pushNamed(
                        Routes.categoryScreen,
                        arguments: {
                          'extraArgs': 'Express Delivery',
                          'expressDelivery': true,
                        },
                      );
                    },
                    isAsset: true,
                  ),
                  const SizedBox(width: 10),
                  CardItem(
                    imageUrl: Assets.of(context).images.subscription_png,
                    title: context.el.discoverCardWeeklySurpriseTitle,
                    buttonText: context.el.discoverCardWeeklySurpriseButton,
                    isAsset: true,
                    onPressed: () {
                      context.pushNamed(
                        Routes.susbcriptionsScreen,
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  // Dynamic new ideas cards
                  ...newIdeas.map(
                    (idea) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CardItem(
                        imageUrl: idea.imageUrl,
                        title: idea.textOnImage,
                        buttonText: idea.textOnButton,
                        isAsset: false,
                        onPressed: (idea.recipient.isNotEmpty) ||
                                (idea.subCategory.isNotEmpty) ||
                                (idea.occasion.isNotEmpty) ||
                                (idea.brand.isNotEmpty)
                            ? () {
                                if (idea.recipient.isNotEmpty ||
                                    idea.subCategory.isNotEmpty ||
                                    idea.occasion.isNotEmpty ||
                                    idea.brand.isNotEmpty) {
                                  log(idea.recipient);
                                  log(idea.occasion);
                                  log(idea.brand);
                                  log(idea.subCategory);

                                  // Create arguments with non-empty values
                                  Map<String, dynamic> arguments = {
                                    'extraArgs': idea.textOnImage,
                                  };

                                  if (idea.recipient.isNotEmpty) {
                                    arguments['recipientId'] = idea.recipient;
                                  }
                                  if (idea.subCategory.isNotEmpty) {
                                    arguments['subCategoryId'] =
                                        idea.subCategory;
                                  }
                                  if (idea.occasion.isNotEmpty) {
                                    arguments['occasionId'] = idea.occasion;
                                  }
                                  if (idea.brand.isNotEmpty) {
                                    arguments['brandId'] = idea.brand;
                                  }
                                  log(arguments.toString());
                                  context.pushNamed(
                                    Routes.categoryScreen,
                                    arguments: arguments,
                                  );
                                }
                              }
                            : null,
                      ),
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

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Text(message),
    );
  }
}

class CardItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String buttonText;
  final VoidCallback? onPressed;
  final bool isAsset;

  const CardItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.buttonText,
    this.onPressed,
    required this.isAsset,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            if (isAsset)
              Image.asset(
                imageUrl,
                colorBlendMode: BlendMode.srcATop,
                color: ColorsManager.black.withAlpha((0.26 * 255).toInt()),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            else
              CachedNetworkImage(
                imageUrl: '${HomeApiConstants.apiBaseUrlForImages}$imageUrl',
                colorBlendMode: BlendMode.srcATop,
                color: ColorsManager.black.withAlpha((0.26 * 255).toInt()),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder: (context, url) => Center(
                  child: LoadingWidget(
                    loadingState: true,
                    height: 60.h,
                    width: 60.w,
                    backgroundColor: ColorsManager.lightLighterGrey,
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: SvgPicture.asset(
                    Assets.of(context).svgs.small_logo_svg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      ColorsManager.black,
                      ColorsManager.transparent,
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.ebGaramond(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorsManager.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: onPressed ?? () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.transparent,
                            side: const BorderSide(color: Colors.white)),
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            color: ColorsManager.white,
                          ),
                        ),
                      ),
                    ],
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
