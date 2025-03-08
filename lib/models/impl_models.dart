import 'package:json_annotation/json_annotation.dart';

part 'impl_models.g.dart';

@JsonSerializable(explicitToJson: true)
class SteemResponse {
  SteemException meta;
  SteemResponsePagination pagination;

  @JsonKey(defaultValue: true)
  dynamic data;

  SteemResponse(
      {required this.meta, required this.pagination, this.data = const {}});

  factory SteemResponse.fromJson(Map<String, dynamic> map) =>
      _$SteemResponseFromJson(map);

  Map<String, dynamic> toJson() => _$SteemResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SteemException implements Exception {
  String error;

  @JsonKey(name: 'error_description')
  String errorDescription;

  SteemException({required this.error, required this.errorDescription});

  factory SteemException.fromJson(Map<String, dynamic> map) =>
      _$SteemExceptionFromJson(map);

  Map<String, dynamic> toJson() => _$SteemExceptionToJson(this);

  @override
  String toString() {
    return '$error: $errorDescription';
  }
}

@JsonSerializable(explicitToJson: true)
class SteemResponsePagination {
  @JsonKey(name: 'entry_id')
  String entryId;

  SteemResponsePagination({required this.entryId});

  factory SteemResponsePagination.fromJson(Map<String, dynamic> map) =>
      _$SteemResponsePaginationFromJson(map);

  Map<String, dynamic> toJson() => _$SteemResponsePaginationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SteemAuthException implements Exception {
  String error;

  @JsonKey(name: 'error_description')
  String errorDescription;

  SteemAuthException({required this.error, required this.errorDescription});

  factory SteemAuthException.fromJson(Map<String, dynamic> map) =>
      _$SteemAuthExceptionFromJson(map);

  Map<String, dynamic> toJson() => _$SteemAuthExceptionToJson(this);
}
