import 'package:json_annotation/json_annotation.dart';

part 'my_orders_request_body.g.dart';

@JsonSerializable()
class MyOrdersRequestBody {
  final int limit;
  final int page;
  final String? search;

  MyOrdersRequestBody({
    required this.limit,
    required this.page,
    this.search,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    // Always include required fields
    data['limit'] = limit;
    data['page'] = page;

    if (search != null && search!.isNotEmpty) data['search'] = search;

    return data;
  }

  factory MyOrdersRequestBody.fromJson(Map<String, dynamic> json) =>
      _$MyOrdersRequestBodyFromJson(json);
}
