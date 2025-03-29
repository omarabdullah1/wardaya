import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import 'subscription_slider.dart';

class SubscriptionPlanCard extends StatefulWidget {
  const SubscriptionPlanCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.currency,
    required this.images,
  });
  final String title;
  final String description;
  final String price;
  final String currency;
  final List<String> images;
  @override
  State<SubscriptionPlanCard> createState() => _SubscriptionPlanCardState();
}

class _SubscriptionPlanCardState extends State<SubscriptionPlanCard> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.h),
          child: Container(
            decoration: BoxDecoration(
              color: ColorsManager.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubscriptionSlider(
                  title: widget.title,
                  images: widget.images,
                ),
                const VerticalSpace(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      widget.description,
                      maxLines: _isExpanded ? 3 : null,
                      overflow: TextOverflow.ellipsis,
                      style: TextStylesInter.font14BlackRegular,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: AnimatedContainer(
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 200),
                      child: Row(
                        children: [
                          Text(
                            !_isExpanded ? context.el.more : context.el.less,
                            style:
                                const TextStyle(color: ColorsManager.mainRose),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const VerticalSpace(height: 18),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.el.startingFrom,
                                style: TextStylesEBGaramond.font12MainRoseBold,
                              ),
                              Text(
                                widget.currency + widget.price,
                                style:
                                    TextStylesEBGaramond.font31MainRoseRegular,
                              ),
                            ],
                          ),
                          Text(
                            context.el.perDelivery,
                            style: TextStylesEBGaramond.font12MainRoseBold,
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          context.pushNamed(Routes.susbcriptionsDurationScreen);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.mainRose,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            fixedSize: Size(175.w, 50.h)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0.w,
                            vertical: 8.0.h,
                          ),
                          child: Text(
                            context.el.subscriptionButton,
                            style: TextStylesInter.font12WhiteBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalSpace(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
