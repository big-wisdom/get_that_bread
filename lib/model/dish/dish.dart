import 'package:get_that_bread/model/food/food.dart';
import 'package:get_that_bread/model/ingredient/ingredient.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dish.g.dart';

@JsonSerializable()
class Dish extends Food {
  Dish(String name, this.description) : super(name);
  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
  Map<String, dynamic> toJson() => _$DishToJson(this);

  List<Ingredient> ingredients = [];
  String description;

  void addIngredient(Ingredient ingredient) {
    ingredients.add(ingredient);
  }

  @override
  String toString() {
    String myString = "$name\n";
    for (int x = 0; x < ingredients.length; x++) {
      myString += "  ⫸${ingredients[x]}\n";
    }
    return myString;
  }
}
