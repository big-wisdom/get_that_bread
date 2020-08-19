// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Eli _$EliFromJson(Map<String, dynamic> json) {
  return Eli(
    json['name'] as String,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$EliToJson(Eli instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };
