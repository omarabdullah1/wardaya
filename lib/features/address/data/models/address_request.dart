import 'package:json_annotation/json_annotation.dart';

part 'address_request.g.dart';

@JsonSerializable()
class AddressRequest {
  final String? userId;
  final String? title;
  final String recipientCity;
  final String recipientArea;
  final String recipientName;
  @JsonKey(name: 'recipientCountryCode')
  final String recipientCountryCode;
  final String recipientPhoneNumber;
  final String recipientAddress;
  final String extraAddressDetails;
  final String latitude;
  final String longitude;

  AddressRequest({
    this.userId,
    required this.title,
    required this.recipientCity,
    required this.recipientArea,
    required this.recipientName,
    required this.recipientCountryCode,
    required this.recipientPhoneNumber,
    required this.recipientAddress,
    required this.extraAddressDetails,
    required this.latitude,
    required this.longitude,
  });

  factory AddressRequest.fromJson(Map<String, dynamic> json) =>
      _$AddressRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddressRequestToJson(this);
}
