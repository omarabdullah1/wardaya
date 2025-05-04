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
  Size get preferredSize => Size.fromHeight(40.h);

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
    _deliveryAreasCubit = getIt<DeliveryAreasCubit>();
    _initializeDeliveryArea();
  }

  Future<void> _initializeDeliveryArea() async {
    try {
      final savedCityId =
          await SharedPrefHelper.getSecuredString(SharedPrefKeys.userAreaId);
      log('Retrieved saved city ID: $savedCityId');

      if (savedCityId != null && savedCityId.isNotEmpty) {
        setState(() {
          _selectedCityId = savedCityId;
        });
      }

      // Always fetch delivery areas to ensure we have the latest data
      _deliveryAreasCubit.getDeliveryAreas();
    } catch (e) {
      log('Error initializing delivery area: $e');
    }
  }

  void _updateCityDisplay(String cityId) {
    if (cityId.isEmpty) return;

    final city = _deliveryAreasCubit.getCityById(cityId);
    if (city != null) {
      setState(() {
        _selectedCityId = cityId;
        _cityName = city.name;
      });
      log('Updated city display to: ${city.name} (ID: $cityId)');
    }
  }

  void _showLoginPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          context.el.loginRequired,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.mainRose,
          ),
        ),
        content: Text(
          context.el.loginToSelectCity,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              context.el.cancel,
              style: GoogleFonts.inter(
                color: ColorsManager.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pushNamed(Routes.loginScreen);
            },
            child: Text(
              context.el.signIn,
              style: GoogleFonts.inter(
                color: ColorsManager.mainRose,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
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
            color: ColorsManager.transparent,
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
            setState(() => _isLoading = false);
          },
          loading: () {
            log("DeliveryAreas: Loading...");
            setState(() => _isLoading = true);
          },
          success: (areas) {
            log("DeliveryAreas: Loaded ${areas.length} areas");
            setState(() => _isLoading = false);
            if (_selectedCityId != null) {
              final city = _deliveryAreasCubit.getCityById(_selectedCityId!);
              if (city != null) {
                log('Successfully restored saved city: ${city.name}');
                _updateCityDisplay(_selectedCityId!);
              }
            }
          },
          updateCity: (response) {
            log("DeliveryAreas: City updated to: ${response.user.selectedDeliveryArea}");
            setState(() => _isLoading = false);
            if (response.user.selectedDeliveryArea != null) {
              _updateCityDisplay(response.user.selectedDeliveryArea!);
            }
          },
          error: (message) {
            log("DeliveryAreas: Error - $message");
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () => _deliveryAreasCubit.getDeliveryAreas(),
                ),
              ),
            );
          },
        );
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            if (_isLoading) return;

            // Check if user is logged in
            if (!isLoggedInUser) {
              _showLoginPrompt(context);
              return;
            }

            // If we don't have delivery areas loaded, fetch them and wait
            if (state is! Success) {
              setState(() => _isLoading = true);
              await _deliveryAreasCubit.getDeliveryAreas();
              setState(() => _isLoading = false);
            }

            // Get the current state after potentially loading
            final currentState = _deliveryAreasCubit.state;
            if (currentState is Success && context.mounted) {
              // Show the bottom sheet with the loaded delivery areas
              final selectedCity = await CitySelectionBottomSheet.show(
                context,
                deliveryAreas: currentState.deliveryAreas,
                currentCityId: _selectedCityId,
              );

              // Only update if user selected a city
              if (selectedCity != null && context.mounted) {
                await _deliveryAreasCubit.updateSelectedCity(selectedCity.id);
              }
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
                      if (_isLoading)
                        Container(
                          constraints: BoxConstraints(maxWidth: 85.w),
                          child: const Center(
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    ColorsManager.white),
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          constraints: BoxConstraints(maxWidth: 85.w),
                          child: Text(
                            _cityName.isEmpty
                                ? context.el.selectCityTitle
                                : _cityName,
                            style: GoogleFonts.inter(
                              color: ColorsManager.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              decoration: !isLoggedInUser
                                  ? TextDecoration.underline
                                  : null,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: ColorsManager.white,
                        size: 18,
                        semanticLabel: !isLoggedInUser
                            ? context.el.loginToSelectCity
                            : null,
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
        icon: Icon(
          Icons.search,
          color: ColorsManager.white,
          size: 20.r,
        ),
        onPressed: () {
          context.pushNamed(Routes.searchScreen);
        },
      ),
    );
  }
}
