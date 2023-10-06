import 'package:json_annotation/json_annotation.dart';

part 'exception_response.g.dart';

@JsonSerializable()
class ExceptionResponse {
  final String? error;
  final String? message;
  final String? type;

  ExceptionResponse(this.error, this.message, this.type);

  factory ExceptionResponse.fromJson(Map<String, dynamic> json) =>
      _$ExceptionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExceptionResponseToJson(this);
}
