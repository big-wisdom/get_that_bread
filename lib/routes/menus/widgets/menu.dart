import 'package:get_that_bread/routes/menus/widgets/dish.dart';

class Menu {
  Menu({
    this.id,
    this.title,
    this.dishes,
  });

  int id;
  String title;
  List<Dish> dishes;
}

List<Menu> generateMenus(int numberOfMenus) {
  return List.generate(
    numberOfMenus,
        (int index) {
      return Menu(
        id: index,
        title: 'Menu $index',
        dishes: generateDishes(7),
      );
    },
  );
}