import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/blocs/general/cubit/general_cubit.dart';
import 'package:wardaya/core/helpers/extensions.dart';
import 'package:wardaya/core/theming/colors.dart';
import '../../../core/helpers/constants.dart';
import '../logic/cubit/search_cubit.dart';
import 'widgets/search_app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 246, 242, 1),
      resizeToAvoidBottomInset: true,
      appBar: const SearchAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 25.0,
        ),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<SearchCubit>().emitSearchStates();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(context.screenWidth.w, 40.h),
                alignment: AlignmentDirectional.center,
                backgroundColor: ColorsManager.mainRose,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: context.read<GeneralCubit>().lang ==
                          Constants.arLang
                      ? [
                          Text(
                            context.el.searchButton,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                          const SizedBox(width: 8.0),
                          const Icon(Icons.search, color: Colors.white),
                        ]
                      : [
                          const Icon(Icons.search, color: Colors.white),
                          const SizedBox(width: 8.0),
                          Text(
                            context.el.searchButton,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
