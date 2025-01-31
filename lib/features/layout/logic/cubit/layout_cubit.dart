import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  int currentIndex = 0;
  LayoutCubit() : super(const LayoutState.initial());

  void changeIndex(int index) async {
    currentIndex = index;
    emit(LayoutState.changeIndex(currentIndex));
  }
}
