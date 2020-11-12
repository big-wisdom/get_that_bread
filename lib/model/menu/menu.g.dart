// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
    json['name'] as String,
  )
    ..id = json['id'] as String
    ..dishes = (json['dishes'] as List)
        ?.map((e) =>
            e == null ? null : DishWrapper.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'dishes': instance.dishes?.map((e) => e?.toJson())?.toList(),
    };
