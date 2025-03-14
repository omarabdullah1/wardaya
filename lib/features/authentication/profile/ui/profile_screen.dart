import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:wardaya/core/theming/colors.dart';
import 'package:wardaya/core/widgets/app_app_bar.dart';
import 'package:wardaya/features/authentication/profile/logic/cubit/profile_cubit.dart';

import '../logic/cubit/profile_state.dart';
import 'widgets/profile_builder.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsManager.offWhite,
          extendBodyBehindAppBar: true,
          appBar: AppAppBar(title: context.el.profileScreenTitle),
          body: SafeArea(
            child: RefreshIndicator(
                onRefresh: () async {
                  context.read<ProfileCubit>().getProfile();
                },
                child: const ProfileBuilder()),
          ),
        );
      },
    );
  }
}
