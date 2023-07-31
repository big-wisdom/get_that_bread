// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dish _$DishFromJson(Map<String, dynamic> json) => Dish(
      json['name'] as String,
      json['description'] as String,
    )
      ..id = json['id'] as String
      ..ingredients = (json['ingredients'] as List<dynamic>)
          .map((e) => IngredientWrapper.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DishToJson(Dish instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'ingredients': instance.ingredients.map((e) => e.toJson()).toList(),
      'description': instance.description,
    };
