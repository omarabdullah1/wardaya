import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/home_recipients_response.dart';

part 'recipients_state.freezed.dart';

@freezed
class RecipientsState with _$RecipientsState {
  const factory RecipientsState.initial() = _Initial;
  const factory RecipientsState.loading() = Loading;
  const factory RecipientsState.success(List<Recipient> recipients) = Success;
  const factory RecipientsState.error(String message) = Error;
}
