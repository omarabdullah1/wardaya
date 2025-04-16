import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/invoice_response.dart';

part 'invoices_state.freezed.dart';

@freezed
class InvoicesState with _$InvoicesState {
  const factory InvoicesState.initial() = _Initial;
  const factory InvoicesState.loading() = Loading;
  const factory InvoicesState.success(List<InvoiceItem> response) = Success;
  const factory InvoicesState.error(String message) = Error;
}