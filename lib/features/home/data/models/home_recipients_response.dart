import 'package:json_annotation/json_annotation.dart';

part 'home_recipients_response.g.dart';

@JsonSerializable()
class HomeRecipientsResponse {
  final List<Recipient> recipients;

  HomeRecipientsResponse({required this.recipients});

  factory HomeRecipientsResponse.fromJson(List<Recipient> json) {
    return HomeRecipientsResponse(
      recipients: json
          .map((item) => Recipient.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$HomeRecipientsResponseToJson(this);
}

@JsonSerializable()
class Recipient {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final List<String> images;

  Recipient({
    required this.id,
    required this.name,
    required this.images,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) =>
      _$RecipientFromJson(json);

  Map<String, dynamic> toJson() => _$RecipientToJson(this);
}
