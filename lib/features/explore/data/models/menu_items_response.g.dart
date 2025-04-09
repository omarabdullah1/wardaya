// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      id: json['_id'] as String,
      imageUrl: json['image_url'] as String,
      name: json['name'] as String,
      subMenuItems: (json['subMenuItems'] as List<dynamic>)
          .map((e) => SubMenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      '_id': instance.id,
      'image_url': instance.imageUrl,
      'name': instance.name,
      'subMenuItems': instance.subMenuItems,
    };

SubMenuItem _$SubMenuItemFromJson(Map<String, dynamic> json) => SubMenuItem(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      menuItem: json['menuItem'] as String,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubMenuItemToJson(SubMenuItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'menuItem': instance.menuItem,
      '__v': instance.v,
    };
