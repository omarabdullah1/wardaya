// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteResult _$DeleteResultFromJson(Map<String, dynamic> json) => DeleteResult(
      acknowledged: json['acknowledged'] as bool,
      deletedCount: (json['deletedCount'] as num).toInt(),
    );

Map<String, dynamic> _$DeleteResultToJson(DeleteResult instance) =>
    <String, dynamic>{
      'acknowledged': instance.acknowledged,
      'deletedCount': instance.deletedCount,
    };

DeleteAccountResponse _$DeleteAccountResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteAccountResponse(
      message: json['message'] as String,
      deleteResult:
          DeleteResult.fromJson(json['deleteResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeleteAccountResponseToJson(
        DeleteAccountResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'deleteResult': instance.deleteResult,
    };
