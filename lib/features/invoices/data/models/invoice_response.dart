import 'package:json_annotation/json_annotation.dart';

part 'invoice_response.g.dart';

@JsonSerializable(explicitToJson: true)
class InvoiceItem {
  @JsonKey(name: "_id")
  final String id;
  
  // Updated to handle the complex structure
  @JsonKey(defaultValue: [])
  final List<dynamic> orderID;
  
  // Keep these fields as they are
  final DateTime invoiceDate;
  final String name;
  final String email;
  final String phoneNumber;
  final double totalPrice;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  @JsonKey(name: "__v")
  final int version;

  // Add a fromJson converter for orderID to handle different types
  static List<dynamic> _orderIDFromJson(dynamic json) {
    if (json == null) return [];
    if (json is List) return json;
    return [];
  }

  InvoiceItem({
    required this.id,
    required this.orderID,
    required this.invoiceDate,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.totalPrice,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });
 
  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    // Handle orderID field manually if needed
    var processedJson = Map<String, dynamic>.from(json);
    if (json.containsKey('orderID')) {
      processedJson['orderID'] = _orderIDFromJson(json['orderID']);
    }
    
    return _$InvoiceItemFromJson(processedJson);
  }

  Map<String, dynamic> toJson() => _$InvoiceItemToJson(this);
}

@JsonSerializable()
class InvoicesResponse {
  final List<InvoiceItem> items;

  InvoicesResponse({required this.items});

  // Custom fromJson that handles direct list response
  factory InvoicesResponse.fromJson(dynamic json) {
    if (json is List) {
      // If the API returns a list directly
      return InvoicesResponse(
        items: json.map((item) => InvoiceItem.fromJson(item)).toList(),
      );
    } else if (json is Map<String, dynamic> && json.containsKey('items')) {
      // If the API returns an object with an 'items' field
      return _$InvoicesResponseFromJson(json);
    } else {
      // Handle unexpected format
      throw FormatException('Unexpected JSON format: $json');
    }
  }

  // Static converter method
  static InvoicesResponse convert(dynamic value) {
    return InvoicesResponse.fromJson(value);
  }

  Map<String, dynamic> toJson() => _$InvoicesResponseToJson(this);
}