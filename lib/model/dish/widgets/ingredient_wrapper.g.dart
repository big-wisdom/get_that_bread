// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientWrapper _$IngredientWrapperFromJson(Map<String, dynamic> json) {
  return IngredientWrapper(
    ingredient: json['ingredient'] == null
        ? null
        : Ingredient.fromJson(json['ingredient'] as Map<String, dynamic>),
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$IngredientWrapperToJson(IngredientWrapper instance) =>
    <String, dynamic>{
      'ingredient': instance.ingredient?.toJson(),
      'count': instance.count,
    };
