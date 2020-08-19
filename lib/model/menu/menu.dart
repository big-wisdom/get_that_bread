import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/model/food/food.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu extends Food {
  Menu(String name) : super(name);
  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);

  List<Dish> dishes = [];

  void addDish(Dish dish) {
    dishes.add(dish);
  }

  @override
  String toString() {
    String myString = "$name\n";
    for (int x = 0; x < dishes.length; x++) {
      myString += "  ⫸${dishes[x]}\n";
    }
    return myString;
  }
}
