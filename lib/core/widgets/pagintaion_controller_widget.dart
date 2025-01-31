import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../cubits/pagination_cubit/pagination_cubit.dart';
import '../di/dependency_injection.dart';
import '../helpers/extensions.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';

class PaginationController extends StatefulWidget {
  final int totalPages;
  final int initialPage;
  final ValueChanged<int> onPageChanged;

  const PaginationController({
    super.key,
    required this.totalPages,
    this.initialPage = 1,
    required this.onPageChanged,
  });

  @override
  State<PaginationController> createState() => _PaginationControllerState();
}

class _PaginationControllerState extends State<PaginationController> {
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
  }

  void _changePage(int newPage) {
    if (newPage >= 1 && newPage <= widget.totalPages) {
      setState(() {
        _currentPage = newPage;
      });
      widget.onPageChanged(newPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine the start and end of the page range to display
    int startPage = _currentPage - 1;
    int endPage = _currentPage + 2;

    // Handle the case where the current page is at the start
    if (_currentPage == 1 || _currentPage == 2) {
      startPage = 1;
      endPage = 4;
    }

    // Handle the case where the current page is at the end
    if (_currentPage == widget.totalPages ||
        _currentPage == widget.totalPages - 1) {
      startPage = widget.totalPages - 3;
      endPage = widget.totalPages;
    }

    // Ensure the pages are within the valid range
    startPage = startPage < 1 ? 1 : startPage;
    endPage = endPage > widget.totalPages ? widget.totalPages : endPage;

    return BlocProvider(
      create: (context) => getIt<PaginationCubit>(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: ColorsManager.mainBlue.withAlpha(102),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    size: 15.0,
                  ),
                  onPressed: () => _changePage(_currentPage - 1),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              endPage - startPage + 1,
              (index) {
                int displayPage = startPage + index;
                return GestureDetector(
                  onTap: () => _changePage(displayPage),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    width: context.pOW(6.0).w,
                    height: context.pOH(2.5).h,
                    decoration: BoxDecoration(
                      color: displayPage == _currentPage
                          ? ColorsManager.lightBlue
                          : ColorsManager.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        '$displayPage',
                        style: displayPage == _currentPage
                            ? TextStyles.font12WhiteSemiBold
                            : TextStyles.font12CoolGraySemiBold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _currentPage < endPage
              ? Text(
                  '...',
                  style: TextStyles.font12CoolGraySemiBold,
                )
              : const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: ColorsManager.mainBlue.withAlpha(102),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 15.0,
                  ),
                  onPressed: () => _changePage(_currentPage + 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
