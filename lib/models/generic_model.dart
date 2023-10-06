// https://wamae.medium.com/generics-and-json-serialization-in-flutter-a8d335840d7b
import 'package:json_annotation/json_annotation.dart';

part 'generic_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class GenericModel<T> {
  final T? data;

  GenericModel(this.data);
  factory GenericModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$GenericModelFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$GenericModelToJson(this, toJsonT);
}
