import 'package:json_annotation/json_annotation.dart';

part 'token_manager_model_response.g.dart';

@JsonSerializable()
class TokenManagerModelResponse {
  final String token;

  final DateTime expiresOn;
  final String id;
    final bool enableTwoFactorAuthentication;
  TokenManagerModelResponse(this.token, this.expiresOn,this.id,this.enableTwoFactorAuthentication);

  factory TokenManagerModelResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenManagerModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TokenManagerModelResponseToJson(this);
}
