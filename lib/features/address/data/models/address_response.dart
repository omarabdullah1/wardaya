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
  final String recipientArea;
  final String recipientAddress;
  final String extraAddressDetails;
  final double latitude;
  final double longitude;

  Address({
    required this.id,
    required this.userId,
    required this.title,
    required this.recipientArea,
    required this.recipientAddress,
    required this.extraAddressDetails,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
