// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_update_city_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeUpdateCityResponse _$HomeUpdateCityResponseFromJson(
        Map<String, dynamic> json) =>
    HomeUpdateCityResponse(
      message: json['message'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeUpdateCityResponseToJson(
        HomeUpdateCityResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      id: json['_id'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      bundleItems: json['bundleItems'] as List<dynamic>? ?? [],
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      '_id': instance.id,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'bundleItems': instance.bundleItems,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      id: json['_id'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      gender: json['gender'] as String,
      countryCode: json['country_code'] as String,
      birthDate: json['birth_date'] as String,
      password: json['password'] as String,
      isProfileComplete: json['is_profile_complete'] as bool,
      isBlocked: json['is_blocked'] as bool,
      role: json['role'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: (json['__v'] as num).toInt(),
      phoneNumber: json['phone_number'] as String?,
      cart: (json['cart'] as List<dynamic>?)
              ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      favorites: (json['favorites'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      points: (json['points'] as num?)?.toInt(),
      invoices: (json['invoices'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      userOccasions: (json['userOccasions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      selectedDeliveryArea: json['selectedDeliveryArea'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'wallet': instance.wallet,
      '_id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'gender': instance.gender,
      'country_code': instance.countryCode,
      'birth_date': instance.birthDate,
      'password': instance.password,
      'is_profile_complete': instance.isProfileComplete,
      'is_blocked': instance.isBlocked,
      'role': instance.role,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.version,
      'phone_number': instance.phoneNumber,
      'cart': instance.cart,
      'favorites': instance.favorites,
      'points': instance.points,
      'invoices': instance.invoices,
      'userOccasions': instance.userOccasions,
      'addresses': instance.addresses,
      'selectedDeliveryArea': instance.selectedDeliveryArea,
    };

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      currency: json['currency'] as String,
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'currency': instance.currency,
      'total': instance.total,
    };
