// import 'package:get_that_bread/model/dish/widgets/ingredient_wrapper.dart';
// import 'package:get_that_bread/model/food/food.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'meal.g.dart';
//
// @JsonSerializable(explicitToJson: true)
// class Meal extends Food {
//   Meal(String name) : super(name);
//   factory Meal.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
//   Map<String, dynamic> toJson() => _$DishToJson(this);
//
//   List<IngredientWrapper> ingredients = [];
//   int serves;
//
//   void addIngredient(IngredientWrapper ingredient) {
//     ingredients.add(ingredient);
//   }
//
//   @override
//   String toString() {
//     String myString = "$name\n";
//     for (int i = 0; i < ingredients.length; i++) {
//       myString += "  ⫸${ingredients[i]}\n";
//     }
//     return myString;
//   }
//
//   bool operator ==(o) => o is Meal && o.id == id;
// }