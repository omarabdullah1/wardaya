import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/helpers/spacing.dart';
import 'package:wardaya/core/routing/routes.dart';
import 'package:wardaya/features/home/data/models/home_delivery_areas_response.dart';
import 'package:wardaya/features/home/logic/delivery_areas/delivery_areas_cubit.dart';
import 'package:wardaya/features/home/logic/delivery_areas/delivery_areas_state.dart';
import 'package:wardaya/features/home/ui/widgets/city_selection_bottom_sheet.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class TransparentAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TransparentAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(40.h); // Adjust height as needed

  @override
  State<TransparentAppBar> createState() => _TransparentAppBarState();
}

class _TransparentAppBarState extends State<TransparentAppBar> {
  String? _selectedCityId;
  String _cityName = '';
  bool _isLoading = false;

  late DeliveryAreasCubit _deliveryAreasCubit;

  @override
  void initState() {
    super.initState();
    // Get the DeliveryAreasCubit from dependency injection
    _deliveryAreasCubit = getIt<DeliveryAreasCubit>();

    // Fetch delivery areas when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDeliveryAreas();
    });
  }

  void _fetchDeliveryAreas() {
    log('Manually triggering delivery areas API call...');
    setState(() {
      _isLoading = true;
    });
    _deliveryAreasCubit.getDeliveryAreas();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsManager.transparent,
      elevation: 0,
      toolbarHeight: widget.preferredSize.height,
      titleSpacing: 20,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: ColorsManager.transparent, // Fully transparent background
          ),
        ),
      ),
      title: _buildAppBarContent(context),
    );
  }

  Widget _buildAppBarContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              context.el.appTitle,
              style: TextStylesKammer.font35WhiteRegular,
            ),
          ),
        ),
        BlocProvider.value(
          value: _deliveryAreasCubit,
          child: _buildLocationButton(context),
        ),
        HorizontalSpace(width: 10.w),
        _buildSearchButton(context),
      ],
    );
  }

  Widget _buildLocationButton(BuildContext context) {
    return BlocConsumer<DeliveryAreasCubit, DeliveryAreasState>(
      listener: (context, state) {
        log("DeliveryAreasState changed: ${state.runtimeType}");

        state.when(
          initial: () {
            log("DeliveryAreas: Initial state");
            setState(() {
              _isLoading = false;
            });
          },
          loading: () {
            log("DeliveryAreas: Loading...");
            setState(() {
              _isLoading = true;
            });
          },
          success: (areas) {
            log("DeliveryAreas: Loaded ${areas.length} areas");
            setState(() {
              _isLoading = false;
            });

            // Display details of each area
            for (var area in areas) {
              log("Area: ${area.country} (${area.cities.length} cities)");
              for (var city in area.cities) {
                log("  - ${city.name} (${city.id})");
              }
            }

            // If we have areas and no selected city yet, select the first city by default
            if (areas.isNotEmpty &&
                areas.first.cities.isNotEmpty &&
                _selectedCityId == null) {
              // Try to find Saudi Arabia first
              final area = areas
                  .where((area) => area.country == areas.first.country)
                  .firstOrNull;
              final cities = area?.cities ?? areas.first.cities;

              if (cities.isNotEmpty) {
                setState(() {
                  _selectedCityId = cities.first.id;
                  _cityName = cities.first.name;
                  log("Selected city: $_cityName (${cities.first.id})");
                });
              }
            }
          },
          error: (errorMsg) {
            log("DeliveryAreas: Error - $errorMsg");
            setState(() {
              _isLoading = false;
            });

            // Show error message to user
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error loading delivery areas: $errorMsg"),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () {
                    _fetchDeliveryAreas();
                  },
                ),
              ),
            );
          },
        );
      },
      builder: (context, state) {
        List<DeliveryArea> deliveryAreas = [];

        // Initialize city name with local context if not yet set
        if (_cityName.isEmpty) {
          _cityName = context.el.locationCity;
        }

        state.when(
          initial: () {},
          loading: () {},
          success: (areas) {
            deliveryAreas = areas;

            // If we have a selected city ID, make sure the city name is correct
            if (_selectedCityId != null) {
              for (var area in areas) {
                for (var city in area.cities) {
                  if (city.id == _selectedCityId) {
                    _cityName = city.name;
                    break;
                  }
                }
              }
            }
          },
          error: (_) {},
        );

        return GestureDetector(
          onTap: () {
            log("Location button tapped - state: ${state.runtimeType}, isLoading: $_isLoading, areas: ${deliveryAreas.length}");

            if (_isLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Loading delivery areas, please wait..."),
                  duration: Duration(seconds: 2),
                ),
              );
              return;
            }

            if (deliveryAreas.isEmpty) {
              log("No delivery areas available, retrying API call...");
              _fetchDeliveryAreas();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      "Loading delivery areas, please try again in a moment"),
                  duration: Duration(seconds: 2),
                ),
              );
              return;
            }

            CitySelectionBottomSheet.show(
              context,
              deliveryAreas: deliveryAreas,
              currentCityId: _selectedCityId,
              onCitySelected: (city) {
                setState(() {
                  _selectedCityId = city.id;
                  _cityName = city.name;
                });

                // Here you could also save the selected city ID to SharedPreferences
                // for persistence between app sessions
                log('Selected city: ${city.name} (${city.id})');
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: ColorsManager.black.withAlpha(45),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.el.deliveryTo,
                    style: GoogleFonts.inter(
                      color: ColorsManager.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 85.w,
                        ),
                        child: Text(
                          _cityName,
                          style: GoogleFonts.inter(
                            color: ColorsManager.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: ColorsManager.white,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorsManager.black.withAlpha(45),
      ),
      child: IconButton(
        icon: const Icon(Icons.search, color: ColorsManager.white),
        onPressed: () {
          context.pushNamed(Routes.searchScreen);
        },
      ),
    );
  }
}
