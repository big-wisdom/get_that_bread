// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      json['name'] as String,
    )
      ..id = json['id'] as String
      ..dishes = (json['dishes'] as List<dynamic>)
          .map((e) => DishWrapper.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'dishes': instance.dishes.map((e) => e.toJson()).toList(),
    };
