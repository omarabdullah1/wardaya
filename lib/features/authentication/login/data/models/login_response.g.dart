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
      cart: (json['cart'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
      'birth_date': User.dateTimeToJson(instance.birthDate),
      'is_profile_complete': instance.isProfileComplete,
      'is_blocked': instance.isBlocked,
      'role': instance.role,
      'favorites': instance.favorites,
      'points': instance.points,
      'cart': instance.cart,
      'selectedDeliveryArea': instance.selectedDeliveryArea,
    };

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      total: (json['total'] as num?)?.toInt(),
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'total': instance.total,
      'currency': instance.currency,
    };
