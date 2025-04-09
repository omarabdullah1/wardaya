import 'package:json_annotation/json_annotation.dart';

part 'menu_items_response.g.dart';

class MenuItemsResponse {
  final List<MenuItem> menuItems;

  MenuItemsResponse({
    required this.menuItems,
  });

  factory MenuItemsResponse.fromJson(List<dynamic> json) {
    return MenuItemsResponse(
      menuItems: json.map((item) => MenuItem.fromJson(item)).toList(),
    );
  }

  List<dynamic> toJson() {
    return menuItems.map((item) => item.toJson()).toList();
  }
}

@JsonSerializable()
class MenuItem {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'image_url')
  final String imageUrl;

  final String name;

  final List<SubMenuItem> subMenuItems;

  MenuItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.subMenuItems,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['_id'] as String,
      imageUrl: json['image_url'] as String,
      name: json['name'] as String,
      subMenuItems: (json['subMenuItems'] as List<dynamic>?)
              ?.map((e) => SubMenuItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image_url': imageUrl,
      'name': name,
      'subMenuItems': subMenuItems.map((e) => e.toJson()).toList(),
    };
  }
}

@JsonSerializable()
class SubMenuItem {
  @JsonKey(name: '_id')
  final String id;

  final String name;

  @JsonKey(name: 'image_url')
  final String imageUrl;

  final String menuItem;

  @JsonKey(name: '__v')
  final int? v;

  SubMenuItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.menuItem,
    this.v,
  });

  factory SubMenuItem.fromJson(Map<String, dynamic> json) {
    return SubMenuItem(
      id: json['_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      menuItem: json['menuItem'] as String,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image_url': imageUrl,
      'menuItem': menuItem,
      '__v': v,
    };
  }
}
