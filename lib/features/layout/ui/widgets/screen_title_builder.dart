import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/layout_cubit.dart';
import '../../logic/cubit/layout_state.dart';

class ScreenTitleBuilder extends StatelessWidget {
  const ScreenTitleBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
      builder: (context, state) {
        final index = context.watch<LayoutCubit>().currentIndex;
        String text;
        switch (index) {
          case 0:
            text = 'Net Zero';
            break;
          case 1:
            text = 'Green Shield';
            break;
          case 2:
            text = 'Green Hub';
            break;
          case 3:
            text = 'Chat';
            break;
          case 4:
            text = 'More';
            break;
          default:
            text = 'Net Zero';
        }
        return Text(
          text,
          textAlign: TextAlign.start,
        );
      },
    );
  }
}
