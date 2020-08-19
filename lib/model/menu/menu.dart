import 'package:get_that_bread/model/food/food.dart';
import 'package:get_that_bread/model/menu/widgets/dish_wrapper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable(explicitToJson: true)
class Menu extends Food {
  Menu(String name) : super(name);
  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);

  List<DishWrapper> dishes = [];

  void addDish(DishWrapper dish) {
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
