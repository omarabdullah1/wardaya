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
import 'package:wardaya/core/widgets/loading_widget.dart';
import 'package:wardaya/features/home/logic/delivery_areas/delivery_areas_cubit.dart';
import 'package:wardaya/features/home/logic/delivery_areas/delivery_areas_state.dart';
import 'package:wardaya/features/home/ui/widgets/city_selection_bottom_sheet.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
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

    // Load the selected city ID from SharedPreferences
    _loadSelectedCity();

    // Fetch delivery areas when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchDeliveryAreas();
    });
  }

  Future<void> _loadSelectedCity() async {
    try {
      final savedCityId = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.userAreaId,
      );
      if (savedCityId != null && savedCityId.isNotEmpty) {
        setState(() {
          _selectedCityId = savedCityId;
          log('Loaded saved city ID: $savedCityId');
        });
      }
    } catch (e) {
      log('Error loading saved city: $e');
    }
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
      listenWhen: (previous, current) => true,
      buildWhen: (previous, current) => true,
      listener: (context, state) {
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
            // Show loading dialog
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
          success: (areas) {
            log("DeliveryAreas: Loaded ${areas.length} areas");
            // Dismiss loading dialog if it's showing
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            setState(() {
              _isLoading = false;
            });
            // Update city name if needed
            if (_selectedCityId != null) {
              final city = _deliveryAreasCubit.getCityById(_selectedCityId!);
              if (city != null) {
                setState(() {
                  _cityName = city.name;
                });
              }
            }
          },
          updateCity: (response) {
            log("DeliveryAreas: City updated");
            // Dismiss loading dialog if it's showing
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            setState(() {
              _isLoading = false;
            });
            // Update the city name
            final city = _deliveryAreasCubit
                .getCityById(response.user.selectedDeliveryArea ?? '');
            if (city != null) {
              setState(() {
                _cityName = city.name;
              });
            }
          },
          error: (message) {
            log("DeliveryAreas: Error - $message");
            // Dismiss loading dialog if it's showing
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            setState(() {
              _isLoading = false;
            });
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () => _fetchDeliveryAreas(),
                ),
              ),
            );
          },
        );
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (_isLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Loading delivery areas, please wait..."),
                  duration: Duration(seconds: 2),
                ),
              );
              return;
            }

            if (state is Success) {
              CitySelectionBottomSheet.show(
                context,
                deliveryAreas: state.deliveryAreas,
                currentCityId: _selectedCityId,
                onCitySelected: (city) async {
                  await _deliveryAreasCubit.updateSelectedCity(city.id);
                  setState(() {
                    _selectedCityId = city.id;
                    _cityName = city.name;
                  });
                },
              );
            } else {
              _fetchDeliveryAreas();
            }
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
