import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/invoice_response.dart';
import 'invoices_api_constants.dart';

part 'invoices_service.g.dart';

@RestApi(baseUrl: InvoicesApiConstants.apiBaseUrl)
abstract class InvoicesService {
  factory InvoicesService(Dio dio) = _InvoicesService;

  @GET(InvoicesApiConstants.invoices)
  Future<List<InvoiceItem>> getInvoices();
}
