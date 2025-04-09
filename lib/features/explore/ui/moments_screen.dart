import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wardaya/core/helpers/extensions.dart';

import '../../../core/assets/assets.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/colors.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../home/data/apis/home_api_constants.dart';
import '../../home/data/models/home_occassions_response.dart';
import '../../home/logic/occassions/occassions_cubit.dart';
import '../../home/logic/occassions/occassions_state.dart';

class MomentsScreen extends StatelessWidget {
  const MomentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
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
          context.el.momentsScreenTitle,
          style: GoogleFonts.ebGaramond(
            color: ColorsManager.mainRose,
            fontWeight: FontWeight.w400,
            fontSize: 30.0.sp,
          ),
        ),

        backgroundColor:
            ColorsManager.transparent, // Make the AppBar transparent
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<OccassionsCubit, OccassionsState>(
          builder: (context, state) {
            return state.when(
              initial: () =>
                  const Center(child: Text("Let's explore occasions!")),
              loading: () => _buildLoadingState(),
              success: (List<OccassionsItem> occasions) =>
                  _buildMomentsGrid(occasions),
              error: (String message) => Center(child: Text("Error: $message")),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMomentsGrid(List<OccassionsItem> occasions) {
    return Builder(builder: (context) {
      if (occasions.isEmpty) {
        return const Center(child: Text("No moments available"));
      }

      return RefreshIndicator(
        color: ColorsManager.mainRose,
        onRefresh: () {
          context.read<OccassionsCubit>().getHomeOccassions();
          return Future.value();
        },
        child: GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns
            crossAxisSpacing: 12.0, // Spacing between columns
            mainAxisSpacing: 12.0, // Spacing between rows
            childAspectRatio: 0.8, // Aspect ratio of grid items
          ),
          itemCount: occasions.length,
          itemBuilder: (context, index) {
            return _buildMomentItem(context, occasions[index]);
          },
        ),
      );
    });
  }

  Widget _buildMomentItem(BuildContext context, OccassionsItem occasion) {
    final String name = occasion.name ?? 'Occasion';

    return GestureDetector(
      onTap: () {
        // Pass occasion ID as argument
        Map<String, dynamic> arguments = {
          'occasionId': occasion.id,
          'extraArgs': name,
        };

        context.pushNamed(
          Routes.categoryScreen,
          arguments: arguments,
        );
      },
      child: Column(
        children: [
          SizedBox(
            width: context.pOW(25).w,
            height: context.pOH(8.5).h,
            child: occasion.imageUrl.isEmpty
                ? Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(Icons.category,
                        color: ColorsManager.mainRose),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl:
                          '${HomeApiConstants.apiBaseUrlForImages}${occasion.imageUrl}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) => Container(
                        color: ColorsManager.lightLighterGrey,
                        child: Center(
                          child: LoadingWidget(
                            loadingState: true,
                            height: 60.h,
                            width: 60.w,
                            backgroundColor: ColorsManager.lightLighterGrey,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: const Color(0xFFF0F0F0),
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.of(context).svgs.small_logo_svg,
                            colorFilter: const ColorFilter.mode(
                              ColorsManager.lightGrey,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 8.0.h), // Add spacing between image and text
          SizedBox(
            width: context.pOW(25).w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: ColorsManager.mainRose,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0.sp,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Create a loading state with fake items
  Widget _buildLoadingState() {
    // Create a list of 15 fake items
    final List<OccassionsItem> fakeItems = List.generate(
      15,
      (index) => OccassionsItem(
        id: 'loading_$index',
        name: 'Loading...',
        imageUrl: '',
      ),
    );

    return Skeletonizer(
      enabled: true,
      child: _buildMomentsGrid(fakeItems),
    );
  }
}
