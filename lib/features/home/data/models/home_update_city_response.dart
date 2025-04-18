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
  final String? phoneNumber; // Made optional
  final List<String>? cart; // Made optional
  final List<String>? favorites; // Made optional
  final int? points; // Made optional
  final List<String>? invoices; // Made optional
  @JsonKey(name: 'userOccasions')
  final List<String>? userOccasions; // Made optional
  final List<String>? addresses; // Made optional
  @JsonKey(name: 'selectedDeliveryArea')
  final String? selectedDeliveryArea; // Made optional

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
    this.phoneNumber, // Made optional
    this.cart = const [], // Default empty list
    this.favorites = const [], // Default empty list
    this.points = 0, // Default value
    this.invoices = const [], // Default empty list
    this.userOccasions = const [], // Default empty list
    this.addresses = const [], // Default empty list
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
