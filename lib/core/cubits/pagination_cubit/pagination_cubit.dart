import 'package:flutter_bloc/flutter_bloc.dart';

import 'pagination_state.dart';

class PaginationCubit extends Cubit<PaginationState> {
  PaginationCubit() : super(const PaginationState.initial());
}
