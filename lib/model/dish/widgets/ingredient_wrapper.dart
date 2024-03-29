import 'package:get_that_bread/model/ingredient/ingredient.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ingredient_wrapper.g.dart';

@JsonSerializable(explicitToJson: true)
class IngredientWrapper {
  factory IngredientWrapper.fromJson(Map<String, dynamic> json) =>
      _$IngredientWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientWrapperToJson(this);

  Ingredient ingredient;
  int count;
  bool checked;

  IngredientWrapper({
    required this.ingredient,
    required this.count,
    this.checked = false,
  });

  bool operator ==(o) =>
      o is IngredientWrapper && o.ingredient.id == ingredient.id;
}
