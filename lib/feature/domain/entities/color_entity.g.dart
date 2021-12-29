// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorEntity _$ColorEntityFromJson(Map<String, dynamic> json) => ColorEntity(
      json['colorName'] as String,
      json['colorHaxcode'] as String,
      json['isSeleted'] as bool,
    );

Map<String, dynamic> _$ColorEntityToJson(ColorEntity instance) =>
    <String, dynamic>{
      'colorName': instance.colorName,
      'colorHaxcode': instance.colorHaxcode,
      'isSeleted': instance.isSeleted,
    };
