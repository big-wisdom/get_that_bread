import 'package:json_annotation/json_annotation.dart';

part 'dish.g.dart';

@JsonSerializable()
class Dish {
  String name;
  Dish(this.name);

  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);

  Map<String, dynamic> toJson() => _$DishToJson(this);
}
