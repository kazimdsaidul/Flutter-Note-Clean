import 'package:json_annotation/json_annotation.dart';

part 'color_entity.g.dart';

@JsonSerializable()
class ColorEntity {
  final String colorName;
  final String colorHaxcode;
  bool isSeleted;

  ColorEntity(this.colorName, this.colorHaxcode, this.isSeleted);

  factory ColorEntity.fromJson(Map<String, dynamic> json) =>
      _$ColorEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ColorEntityToJson(this);
}
