import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/home_new_ideas_response.dart';

part 'new_ideas_state.freezed.dart';

@freezed
class NewIdeasState with _$NewIdeasState {
  const factory NewIdeasState.initial() = _Initial;
  const factory NewIdeasState.loading() = Loading;
  const factory NewIdeasState.success(List<HomeNewIdeasItem> newIdeas) =
      Success;
  const factory NewIdeasState.error(String message) = Error;
}
