import 'package:json_annotation/json_annotation.dart';

part 'subscription_duration_response.g.dart';

@JsonSerializable()
class SubscriptionDuration {
  @JsonKey(name: '_id')
  final String id;

  final String duration;
  final int price;

  @JsonKey(name: 'discounted_price')
  final int discountedPrice;

  final DateTime createdAt;
  final DateTime updatedAt;

  @JsonKey(name: '__v')
  final int version;

  SubscriptionDuration({
    required this.id,
    required this.duration,
    required this.price,
    required this.discountedPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory SubscriptionDuration.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDurationFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionDurationToJson(this);
}

class SubscriptionDurationsResponse {
  final List<SubscriptionDuration> durations;

  SubscriptionDurationsResponse({required this.durations});

  factory SubscriptionDurationsResponse.fromJson(dynamic json) {
    if (json is List) {
      try {
        return SubscriptionDurationsResponse(
          durations: json
              .map((item) =>
                  SubscriptionDuration.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
      } catch (e) {
        // Return empty list if there's an error parsing
        return SubscriptionDurationsResponse(durations: []);
      }
    } else if (json is Map<String, dynamic> && json.containsKey('durations')) {
      try {
        final List<dynamic> jsonDurations = json['durations'] as List<dynamic>;
        return SubscriptionDurationsResponse(
          durations: jsonDurations
              .map((item) =>
                  SubscriptionDuration.fromJson(item as Map<String, dynamic>))
              .toList(),
        );
      } catch (e) {
        // Return empty list if there's an error parsing
        return SubscriptionDurationsResponse(durations: []);
      }
    } else {
      // Return empty list for unexpected format instead of throwing exception
      return SubscriptionDurationsResponse(durations: []);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'durations': durations.map((duration) => duration.toJson()).toList(),
    };
  }
}
