// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Component _$ComponentFromJson(Map<String, dynamic> json) => Component(
      json['name'] as String,
      json['type'] as String,
      json['component'] as String,
      json['timestamp'] as bool,
      json['required'] as bool,
      (json['values'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ComponentToJson(Component instance) => <String, dynamic>{
      'name': instance.name,
      'values': instance.values,
      'component': instance.component,
      'type': instance.type,
      'required': instance.required,
      'timestamp': instance.timestamp,
    };
