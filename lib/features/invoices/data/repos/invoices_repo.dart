import 'dart:developer';

import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../apis/invoices_service.dart';
import '../models/invoice_response.dart';

class InvoicesRepo {
  final InvoicesService _apiService;

  InvoicesRepo(this._apiService);

  Future<ApiResult<List<InvoiceItem>>> getInvoices() async {
    try {
      final response = await _apiService.getInvoices();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      log('Error in getInvoices: $error', stackTrace: stackTrace);
      // Handle the error using the ApiErrorHandler
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}