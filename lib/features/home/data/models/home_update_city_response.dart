import 'package:json_annotation/json_annotation.dart';

part 'home_update_city_response.g.dart';

@JsonSerializable()
class HomeUpdateCityResponse {
  final String message;
  final User user;

  HomeUpdateCityResponse({
    required this.message,
    required this.user,
  });

  factory HomeUpdateCityResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeUpdateCityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeUpdateCityResponseToJson(this);
}

@JsonSerializable()
class CartItem {
  @JsonKey(name: '_id')
  final String id;
  final String productId;
  final int quantity;
  @JsonKey(defaultValue: <dynamic>[])
  final List<dynamic> bundleItems;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    this.bundleItems = const [],
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

@JsonSerializable()
class User {
  final Wallet? wallet;
  @JsonKey(name: '_id')
  final String id;
  final String email;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String gender;
  @JsonKey(name: 'country_code')
  final String countryCode;
  @JsonKey(name: 'birth_date')
  final String birthDate;
  final String password;
  @JsonKey(name: 'is_profile_complete')
  final bool isProfileComplete;
  @JsonKey(name: 'is_blocked')
  final bool isBlocked;
  final String role;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int version;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(defaultValue: <CartItem>[])
  final List<CartItem> cart;
  @JsonKey(defaultValue: <String>[])
  final List<String> favorites;
  final int? points;
  @JsonKey(defaultValue: <String>[])
  final List<String> invoices;
  @JsonKey(name: 'userOccasions', defaultValue: <String>[])
  final List<String> userOccasions;
  @JsonKey(defaultValue: <String>[])
  final List<String> addresses;
  @JsonKey(name: 'selectedDeliveryArea')
  final String? selectedDeliveryArea;

  User({
    this.wallet,
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.countryCode,
    required this.birthDate,
    required this.password,
    required this.isProfileComplete,
    required this.isBlocked,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.phoneNumber,
    this.cart = const [],
    this.favorites = const [],
    this.points,
    this.invoices = const [],
    this.userOccasions = const [],
    this.addresses = const [],
    this.selectedDeliveryArea,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Wallet {
  final String currency;
  final int total;

  Wallet({
    required this.currency,
    required this.total,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
