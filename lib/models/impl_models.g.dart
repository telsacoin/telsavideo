// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'impl_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SteemResponse _$SteemResponseFromJson(Map<String, dynamic> json) {
  return SteemResponse(
    meta: SteemException.fromJson(json['meta'] as Map<String, dynamic>),
    pagination: SteemResponsePagination.fromJson(
        json['pagination'] as Map<String, dynamic>),
    data: json['data'] ?? true,
  );
}

Map<String, dynamic> _$SteemResponseToJson(SteemResponse instance) =>
    <String, dynamic>{
      'meta': instance.meta.toJson(),
      'pagination': instance.pagination.toJson(),
      'data': instance.data,
    };

SteemException _$SteemExceptionFromJson(Map<String, dynamic> json) {
  return SteemException(
    error: json['error'] as String,
    errorDescription: json['error_description'] as String,
  );
}

Map<String, dynamic> _$SteemExceptionToJson(SteemException instance) =>
    <String, dynamic>{
      'error': instance.error,
      'error_description': instance.errorDescription,
    };

SteemResponsePagination _$SteemResponsePaginationFromJson(
    Map<String, dynamic> json) {
  return SteemResponsePagination(
    entryId: json['entry_id'] as String,
  );
}

Map<String, dynamic> _$SteemResponsePaginationToJson(
        SteemResponsePagination instance) =>
    <String, dynamic>{
      'entry_id': instance.entryId,
    };

SteemAuthException _$SteemAuthExceptionFromJson(Map<String, dynamic> json) {
  return SteemAuthException(
    error: json['error'] as String,
    errorDescription: json['error_description'] as String,
  );
}

Map<String, dynamic> _$SteemAuthExceptionToJson(SteemAuthException instance) =>
    <String, dynamic>{
      'error': instance.error,
      'error_description': instance.errorDescription,
    };
