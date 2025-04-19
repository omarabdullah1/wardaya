import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? message;
  String? token;
  User? user;

  LoginResponse({this.message, this.token, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class User {
  Wallet? wallet;
  @JsonKey(name: '_id')
  String? id;
  String? email;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  String? gender;
  @JsonKey(name: 'country_code')
  String? countryCode;
  @JsonKey(
      name: 'birth_date', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  DateTime? birthDate;
  @JsonKey(name: 'is_profile_complete')
  bool? isProfileComplete;
  @JsonKey(name: 'is_blocked')
  bool? isBlocked;
  String? role;
  List<String>? favorites;
  int? points;
  List<CartItem>? cart;
  @JsonKey(name: 'selectedDeliveryArea')
  String? selectedDeliveryArea;
  List<String>? invoices;
  List<String>? userOccasions;
  List<String>? addresses;
  @JsonKey(
      name: 'createdAt', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  DateTime? createdAt;
  @JsonKey(
      name: 'updatedAt', fromJson: dateTimeFromJson, toJson: dateTimeToJson)
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? version;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  User({
    this.wallet,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.countryCode,
    this.birthDate,
    this.isProfileComplete,
    this.isBlocked,
    this.role,
    this.favorites,
    this.points,
    this.cart,
    this.selectedDeliveryArea,
    this.invoices,
    this.userOccasions,
    this.addresses,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  static DateTime? dateTimeFromJson(String? date) =>
      date != null ? DateTime.parse(date) : null;

  static String? dateTimeToJson(DateTime? date) => date?.toIso8601String();
}

@JsonSerializable()
class CartItem {
  String? productId;
  int? quantity;
  List<String>? bundleItems;
  @JsonKey(name: '_id')
  String? id;

  CartItem({
    this.productId,
    this.quantity,
    this.bundleItems,
    this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

@JsonSerializable()
class Wallet {
  int? total;
  String? currency;

  Wallet({
    this.total,
    this.currency,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
