// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientWrapper _$IngredientWrapperFromJson(Map<String, dynamic> json) =>
    IngredientWrapper(
      ingredient:
          Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>),
      count: json['count'] as int,
      checked: json['checked'] as bool,
    );

Map<String, dynamic> _$IngredientWrapperToJson(IngredientWrapper instance) =>
    <String, dynamic>{
      'ingredient': instance.ingredient.toJson(),
      'count': instance.count,
      'checked': instance.checked,
    };
