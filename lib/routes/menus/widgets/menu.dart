import 'package:get_that_bread/routes/menus/widgets/dish.dart';

class Menu {
  Menu({
    this.id,
    this.name,
    this.dishes,
  });

  int id;
  String name;
  List<Dish> dishes;
}

List<Menu> generateMenus(int numberOfMenus) {
  return List.generate(
    numberOfMenus,
        (int index) {
      return Menu(
        id: index,
        name: 'Menu $index',
        dishes: generateDishes(7),
      );
    },
  );
}