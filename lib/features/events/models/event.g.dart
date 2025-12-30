// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
      id: json['id'] as String,
      name: json['name'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      calculationType:
          $enumDecode(_$CalculationTypeEnumMap, json['calculation_type']),
      imageUrl: json['image_url'] as String?,
      colorHex: json['color_hex'] as String?,
    );

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'calculation_type': _$CalculationTypeEnumMap[instance.calculationType]!,
      'image_url': instance.imageUrl,
      'color_hex': instance.colorHex,
    };

const _$CalculationTypeEnumMap = {
  CalculationType.birthday: 'birthday',
  CalculationType.anniversary: 'anniversary',
  CalculationType.holiday: 'holiday',
  CalculationType.memory: 'memory',
  CalculationType.general: 'general',
};
