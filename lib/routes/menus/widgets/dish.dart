class Dish {
  Dish({
    this.id,
    this.name,
    this.description,
    this.ingredients,
  });

  int id;
  String name;
  String description;
  List<String> ingredients;
}

List<Dish> generateDishes(int numberOfDishes) {
  return List.generate(
    numberOfDishes,
        (int index) {
      return Dish(
        id: index,
        name: 'Dish $index',
        description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        ingredients: ["Eggs", "Bread", "Milk", "Cheese", "Bacon", "Chips", "Salsa"],
      );
    },
  );
}