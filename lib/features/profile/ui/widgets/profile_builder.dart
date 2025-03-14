import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/profile_cubit.dart';
import '../../logic/cubit/profile_state.dart';
import 'profile_body.dart';

class ProfileBuilder extends StatelessWidget {
  const ProfileBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current is ProfileSuccess || current is Error || current is Loading,
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (profileResponse) {
            return const ProfileBody();
          },
          error: (error) => Text(error),
        );
      },
    );
  }
}
