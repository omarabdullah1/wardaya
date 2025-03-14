import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class Wallet {
  String? currency;
  num? total;

  Wallet({this.currency, this.total});

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
  Map<String, dynamic> toJson() => _$WalletToJson(this);
}

@JsonSerializable()
class Favorite {
  @JsonKey(name: "price")
  Price? price;
  List<dynamic>? occasions;
  int? points;
  List<dynamic>? bundleItems;
  List<dynamic>? colors;
  List<dynamic>? recipients;
  List<dynamic>? bundleTypes;
  @JsonKey(name: "_id")
  String? id;
  String? sku;
  String? title;
  String? description;
  String? productType;
  List<String>? images;
  List<String>? categories;
  List<String>? subCategories;
  bool? expressDelivery;
  String? createdAt;
  String? updatedAt;
  int? v;
  List<dynamic>? components;

  Favorite({
    this.price,
    this.occasions,
    this.points,
    this.bundleItems,
    this.colors,
    this.recipients,
    this.bundleTypes,
    this.id,
    this.sku,
    this.title,
    this.description,
    this.productType,
    this.images,
    this.categories,
    this.subCategories,
    this.expressDelivery,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.components,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}

@JsonSerializable()
class Price {
  num? total;
  String? currency;

  Price({this.total, this.currency});

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);
  Map<String, dynamic> toJson() => _$PriceToJson(this);
}

@JsonSerializable()
class CartItem {
  String? productId;
  int? quantity;
  @JsonKey(name: "_id")
  String? id;

  CartItem({this.productId, this.quantity, this.id});

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

@JsonSerializable()
class ProfileResponse {
  Wallet? wallet;
  @JsonKey(name: "_id")
  String? id;
  String? email;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  String? gender;
  @JsonKey(name: "country_code")
  String? countryCode;
  @JsonKey(name: "birth_date")
  String? birthDate;
  String? password;
  @JsonKey(name: "is_profile_complete")
  bool? isProfileComplete;
  @JsonKey(name: "is_blocked")
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  @JsonKey(name: "__v")
  int? v;
  @JsonKey(name: "phone_number")
  String? phoneNumber;
  List<Favorite>? favorites;
  String? role;
  int? points;
  List<CartItem>? cart;

  ProfileResponse({
    this.wallet,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.countryCode,
    this.birthDate,
    this.password,
    this.isProfileComplete,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.phoneNumber,
    this.favorites,
    this.role,
    this.points,
    this.cart,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
