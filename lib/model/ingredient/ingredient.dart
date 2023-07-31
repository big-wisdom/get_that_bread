import 'package:get_that_bread/model/food/food.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';

@JsonSerializable()
class Ingredient extends Food {
  Ingredient({
    required String name,
    required this.unit,
  }) : super(name);
  String unit;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);

  @override
  String toString() {
    return name;
  }
}
