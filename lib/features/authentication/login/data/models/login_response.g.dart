// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      message: json['message'] as String?,
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      gender: json['gender'] as String?,
      countryCode: json['country_code'] as String?,
      birthDate: User.dateTimeFromJson(json['birth_date'] as String?),
      isProfileComplete: json['is_profile_complete'] as bool?,
      isBlocked: json['is_blocked'] as bool?,
      role: json['role'] as String?,
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      points: (json['points'] as num?)?.toInt(),
      cart: (json['cart'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedDeliveryArea: json['selectedDeliveryArea'] as String?,
      invoices: (json['invoices'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      userOccasions: (json['userOccasions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: User.dateTimeFromJson(json['createdAt'] as String?),
      updatedAt: User.dateTimeFromJson(json['updatedAt'] as String?),
      version: (json['__v'] as num?)?.toInt(),
      phoneNumber: json['phone_number'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'wallet': instance.wallet,
      '_id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'gender': instance.gender,
      'country_code': instance.countryCode,
      'birth_date': User.dateTimeToJson(instance.birthDate),
      'is_profile_complete': instance.isProfileComplete,
      'is_blocked': instance.isBlocked,
      'role': instance.role,
      'favorites': instance.favorites,
      'points': instance.points,
      'cart': instance.cart,
      'selectedDeliveryArea': instance.selectedDeliveryArea,
      'invoices': instance.invoices,
      'userOccasions': instance.userOccasions,
      'addresses': instance.addresses,
      'createdAt': User.dateTimeToJson(instance.createdAt),
      'updatedAt': User.dateTimeToJson(instance.updatedAt),
      '__v': instance.version,
      'phone_number': instance.phoneNumber,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      productId: json['productId'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      bundleItems: (json['bundleItems'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'bundleItems': instance.bundleItems,
      '_id': instance.id,
    };

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      total: (json['total'] as num?)?.toInt(),
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'total': instance.total,
      'currency': instance.currency,
    };
