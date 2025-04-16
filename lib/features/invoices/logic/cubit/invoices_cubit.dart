import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/invoice_response.dart';
import '../../data/repos/invoices_repo.dart';
import 'invoices_state.dart';

class InvoicesCubit extends Cubit<InvoicesState> {
  final InvoicesRepo _invoicesRepo;

  InvoicesCubit(this._invoicesRepo) : super(const InvoicesState.initial());

  Future<void> getInvoices() async {
    emit(const InvoicesState.loading());
    try {
      final response = await _invoicesRepo.getInvoices();
      response.when(
        success: (List<InvoiceItem> data) {
          log('Successfully received Invoices data with ${data.length} items');
          emit(InvoicesState.success(data));
        },
        failure: (error) {
          log('Error fetching Invoices data: ${error.message}, Details: ${error.message} - and error ${error.error}');
          emit(InvoicesState.error(
              error.message ?? 'Failed to fetch Invoices data'));
        },
      );
    } catch (e, stackTrace) {
      log('Invoices unexpected error: $e', stackTrace: stackTrace);
      emit(InvoicesState.error(
          'An unexpected error occurred: ${e.toString()}'));
    }
  }
}