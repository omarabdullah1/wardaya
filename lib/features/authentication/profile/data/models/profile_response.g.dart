// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      currency: json['currency'] as String?,
      total: json['total'] as num?,
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'currency': instance.currency,
      'total': instance.total,
    };

Favorite _$FavoriteFromJson(Map<String, dynamic> json) => Favorite(
      price: json['price'] == null
          ? null
          : Price.fromJson(json['price'] as Map<String, dynamic>),
      occasions: json['occasions'] as List<dynamic>?,
      points: (json['points'] as num?)?.toInt(),
      bundleItems: json['bundleItems'] as List<dynamic>?,
      colors: json['colors'] as List<dynamic>?,
      recipients: json['recipients'] as List<dynamic>?,
      bundleTypes: json['bundleTypes'] as List<dynamic>?,
      id: json['_id'] as String?,
      sku: json['sku'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      productType: json['productType'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      expressDelivery: json['expressDelivery'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['v'] as num?)?.toInt(),
      components: json['components'] as List<dynamic>?,
    );

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'price': instance.price,
      'occasions': instance.occasions,
      'points': instance.points,
      'bundleItems': instance.bundleItems,
      'colors': instance.colors,
      'recipients': instance.recipients,
      'bundleTypes': instance.bundleTypes,
      '_id': instance.id,
      'sku': instance.sku,
      'title': instance.title,
      'description': instance.description,
      'productType': instance.productType,
      'images': instance.images,
      'categories': instance.categories,
      'subCategories': instance.subCategories,
      'expressDelivery': instance.expressDelivery,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'v': instance.v,
      'components': instance.components,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      total: json['total'] as num?,
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'total': instance.total,
      'currency': instance.currency,
    };

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      productId: json['productId'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      '_id': instance.id,
    };

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      wallet: json['wallet'] == null
          ? null
          : Wallet.fromJson(json['wallet'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      gender: json['gender'] as String?,
      countryCode: json['country_code'] as String?,
      birthDate: json['birth_date'] as String?,
      password: json['password'] as String?,
      isProfileComplete: json['is_profile_complete'] as bool?,
      isBlocked: json['is_blocked'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
      phoneNumber: json['phone_number'] as String?,
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => Favorite.fromJson(e as Map<String, dynamic>))
          .toList(),
      role: json['role'] as String?,
      points: (json['points'] as num?)?.toInt(),
      cart: (json['cart'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
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
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'phone_number': instance.phoneNumber,
      'favorites': instance.favorites,
      'role': instance.role,
      'points': instance.points,
      'cart': instance.cart,
    };
