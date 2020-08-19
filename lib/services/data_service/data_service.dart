import 'package:flutter/foundation.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/model/ingredient/ingredient.dart';
import 'package:get_that_bread/model/menu/menu.dart';
import 'package:get_that_bread/services/persistence_service/persistence_service.dart';

// this will control a list of Menus, list of Dishes, and list of Ingredients
class DataService extends ChangeNotifier {
  final PersistenceService _persistenceService = PersistenceService();

  List<Menu> menus = [];
  List<Dish> dishes = [];
  List<Ingredient> ingredients = [];
  List<Ingredient> shoppingList = [];

  DataService() {
    _loadEverything();
  }

  void populateShoppingList() {
    // TODO: Eventually pass the menu to work from to this method
    print("Populating Shopping List");
    Menu menu = menus[0];
    shoppingList = [];
    for (int dish = 0; dish < menu.dishes.length; dish++) {
      Dish currentDish = menu.dishes[dish];
      for (int ingredient = 0;
          ingredient < currentDish.ingredients.length;
          ingredient++) {
        shoppingList.add(currentDish.ingredients[ingredient]);
      }
    }
    notifyListeners();
  }

  void _loadEverything() {
    _loadMenus();
    _loadDishes();
    _loadIngredients();
    _loadShoppingList();
  }

  Future<void> _loadMenus() async {
    final result = await _persistenceService.decodeMenus();
    menus = result.map((e) => Menu.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> _loadDishes() async {
    final result = await _persistenceService.decodeDishes();
    dishes = result.map((e) => Dish.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> _loadIngredients() async {
    final result = await _persistenceService.decodeIngredients();
    ingredients = result.map((e) => Ingredient.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> _loadShoppingList() async {
    final result = await _persistenceService.decodeShoppingList();
    shoppingList = result.map((e) => Ingredient.fromJson(e)).toList();
    notifyListeners();
  }

  void printMenus() async {
    await _loadMenus(); // is this finishing before it moves to the next line?
    print("Menus");
    for (int x = 0; x < menus.length; x++) {
      print("${menus[x]}");
    }
  }

  void printDishes() async {
    await _loadDishes();
    print("Dishes");
    for (int x = 0; x < dishes.length; x++) {
      debugPrint("${dishes[x]}");
    }
  }

  void printIngredients() async {
    await _loadIngredients();
    print("Ingredients");
    for (int x = 0; x < ingredients.length; x++) {
      debugPrint("${ingredients[x]}");
    }
  }

  void printShoppingList() async {
    await _loadIngredients();
    print("Ingredients");
    for (int x = 0; x < ingredients.length; x++) {
      debugPrint("${shoppingList[x]}");
    }
  }

  void addMenu(Menu menu) {
    print("Adding Menu");
    menus.add(menu);
    for (Dish dish in menu.dishes) {
      if (!dishes.contains(dish)) addDish(dish);
    }
    _persistenceService.encodeMenus(menus);
    notifyListeners();
  }

  void addDish(Dish dish) {
    print("Adding Dish");
    dishes.add(dish);
    for (Ingredient ingredient in dish.ingredients) {
      if (!ingredients.contains(ingredient)) addIngredient(ingredient);
    }
    _persistenceService.encodeDishes(dishes);
    notifyListeners();
  }

  void addIngredient(Ingredient ingredient) {
    print("Adding Ingredient");
    ingredients.add(ingredient);
    _persistenceService.encodeIngredients(ingredients);
    notifyListeners();
  }

  void addToShoppingList(Ingredient ingredient) {
    print("Adding Ingredient to Shopping List");
    shoppingList.add(ingredient);
    _persistenceService.encodeShoppingList(shoppingList);
  }

  Future<List<Dish>> searchDishes(String pattern) async {
    final fuse = Fuzzy(
      dishes,
      options: FuzzyOptions(
        keys: [
          WeightedKey(
              name: "name",
              getter: (dish) {
                return dish.name;
              },
              weight: 1)
        ],
      ),
    );

    final result = fuse.search(pattern);

    debugPrint("Results");
    result.forEach(print);

    return Future.value(result.map((e) => e.item as Dish).toList());
  }

  Future<List<Ingredient>> searchIngredients(String pattern) async {
    final fuse = Fuzzy(
      ingredients,
      options: FuzzyOptions(
        keys: [
          WeightedKey(
              name: "name",
              getter: (ingredient) {
                return ingredient.name;
              },
              weight: 1)
        ],
      ),
    );

    final result = fuse.search(pattern);

    debugPrint("Results");
    result.forEach(print);

    return Future.value(result.map((e) => e.item as Ingredient).toList());
  }

  void removeMenu(Menu menu) {
    print("Removing Menu");
    menus.remove(menu);
    _persistenceService.encodeMenus(menus);
  }

  void removeDish(Dish dish) {
    print("Removing Dish");
    dishes.remove(dish);
    _persistenceService.encodeDishes(dishes);
  }

  void removeIngredient(Ingredient ingredient) {
    print("Removing Ingredient");
    ingredients.remove(ingredient);
    _persistenceService.encodeIngredients(ingredients);
  }
}
