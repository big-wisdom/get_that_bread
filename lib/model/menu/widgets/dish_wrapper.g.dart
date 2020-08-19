// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DishWrapper _$DishWrapperFromJson(Map<String, dynamic> json) {
  return DishWrapper(
    dish: json['dish'] == null
        ? null
        : Dish.fromJson(json['dish'] as Map<String, dynamic>),
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$DishWrapperToJson(DishWrapper instance) =>
    <String, dynamic>{
      'dish': instance.dish?.toJson(),
      'count': instance.count,
    };
