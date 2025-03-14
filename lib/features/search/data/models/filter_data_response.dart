import 'package:json_annotation/json_annotation.dart';

part 'filter_data_response.g.dart'; // Updated part file name

@JsonSerializable()
class FilterDataResponse {
  final List<ColorOption> colors;
  final List<Recipient> recipients;
  final List<BundleType> bundleTypes;
  final List<Occasion> occasions;
  final List<PriceRange> priceRanges;

  FilterDataResponse({
    required this.colors,
    required this.recipients,
    required this.bundleTypes,
    required this.occasions,
    required this.priceRanges,
  });

  factory FilterDataResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDataResponseToJson(this);
}

@JsonSerializable()
class PriceRange {
  @JsonKey(name: '_id')
  final String id;
  final int count;

  PriceRange({
    required this.id,
    required this.count,
  });

  factory PriceRange.fromJson(Map<String, dynamic> json) =>
      _$PriceRangeFromJson(json);

  Map<String, dynamic> toJson() => _$PriceRangeToJson(this);
}

// Reuse existing models (ensure these are imported or defined in the same file)
@JsonSerializable()
class ColorOption {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final int count;

  ColorOption({
    required this.id,
    required this.name,
    required this.count,
  });

  factory ColorOption.fromJson(Map<String, dynamic> json) =>
      _$ColorOptionFromJson(json);

  Map<String, dynamic> toJson() => _$ColorOptionToJson(this);
}

@JsonSerializable()
class Recipient {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final int count;

  Recipient({
    required this.id,
    required this.name,
    required this.count,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) =>
      _$RecipientFromJson(json);

  Map<String, dynamic> toJson() => _$RecipientToJson(this);
}

@JsonSerializable()
class BundleType {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final int count;

  BundleType({
    required this.id,
    required this.name,
    required this.count,
  });

  factory BundleType.fromJson(Map<String, dynamic> json) =>
      _$BundleTypeFromJson(json);

  Map<String, dynamic> toJson() => _$BundleTypeToJson(this);
}

@JsonSerializable()
class Occasion {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final int count;

  Occasion({
    required this.id,
    required this.name,
    required this.count,
  });

  factory Occasion.fromJson(Map<String, dynamic> json) =>
      _$OccasionFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionToJson(this);
}
