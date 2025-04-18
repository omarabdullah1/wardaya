import 'package:json_annotation/json_annotation.dart';

part 'address_response.g.dart';

@JsonSerializable()
class AddressResponse {
  final List<Address> addresses;

  AddressResponse({required this.addresses});

  factory AddressResponse.fromJson(List<Address> json) {
    return AddressResponse(
      addresses: json
          .map((item) => Address.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);
}

@JsonSerializable()
class Address {
  @JsonKey(name: '_id')
  final String id;
  final String userId;
  final String title;
  @JsonKey(defaultValue: '')
  final String recipientArea;
  @JsonKey(defaultValue: '')
  final String recipientAddress;
  @JsonKey(defaultValue: '')
  final String extraAddressDetails;
  final String? recipientPhoneNumber;
  final String? recipientName;
  final String? recipientCountryCode;
  @JsonKey(defaultValue: 0.0)
  final double latitude;
  @JsonKey(defaultValue: 0.0)
  final double longitude;
  @JsonKey(name: '__v', defaultValue: 0)
  final int version;

  Address({
    required this.id,
    required this.userId,
    required this.title,
    required this.recipientArea,
    required this.recipientAddress,
    required this.extraAddressDetails,
    this.recipientPhoneNumber,
    this.recipientName,
    this.recipientCountryCode,
    required this.latitude,
    required this.longitude,
    required this.version,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
