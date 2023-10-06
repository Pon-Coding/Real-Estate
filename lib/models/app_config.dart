import 'package:json_annotation/json_annotation.dart';

part 'app_config.g.dart';

@JsonSerializable()
class AppConfig {
  final String? apiUrl;
  final String? apiVersion;
  final String? defaultLanguage;
  final String? privacyPolicy;
  final String? termsConditions;
  final String? privacyPolicyAndTermsConditions;
  final String? appstoreLink;
  final String? playstoreLink;

  AppConfig({
    this.apiUrl,
    this.apiVersion,
    this.defaultLanguage,
    this.privacyPolicy,
    this.termsConditions,
    this.privacyPolicyAndTermsConditions,
    this.appstoreLink,
    this.playstoreLink,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);
  Map<String, dynamic> toJson() => _$AppConfigToJson(this);
}
