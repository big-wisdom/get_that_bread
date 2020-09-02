import 'package:flutter/foundation.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/model/dish/widgets/ingredient_wrapper.dart';
import 'package:get_that_bread/model/ingredient/ingredient.dart';
import 'package:get_that_bread/model/menu/menu.dart';
import 'package:get_that_bread/model/menu/widgets/dish_wrapper.dart';
import 'package:get_that_bread/services/persistence_service/persistence_service.dart';

// this will control a list of Menus, list of Dishes, and list of Ingredients
class DataService extends ChangeNotifier {
  final PersistenceService _persistenceService = PersistenceService();

  List<Menu> menus = [];
  List<Dish> dishes = [];
  List<Ingredient> ingredients = [];
  List<IngredientWrapper> shoppingList = [];

  DataService() {
    _loadEverything();
  }

  void populateShoppingList(Menu menu) async {
    // TODO: Eventually pass the menu to work from to this method
    print("Populating Shopping List");
    shoppingList = [];
    for (DishWrapper dishWrapper in menu.dishes) {
      for (IngredientWrapper iw in dishWrapper.dish.ingredients) {
        shoppingList.add(iw);
      }
    }
    await _persistenceService.encodeShoppingList(shoppingList);
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
    shoppingList = result.map((e) => IngredientWrapper.fromJson(e)).toList();
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
    // don't worry about menu already existing, auto complete on the title should handle that
    // add menu to menus list
    // add each dish to dishes list (which would mean that each dish is stored in the menu itself)
    // notifyListeners
    print("Adding Menu");
    menus.add(menu);
    for (DishWrapper dishWrapper in menu.dishes) {
      if (!dishes.contains(dishWrapper.dish)) addDish(dishWrapper.dish);
    }
    _persistenceService.encodeMenus(menus);
    notifyListeners();
  }

  Future<void> addDish(Dish dish) async {
    // check if dish is in dishes list already
    // if not,
    //add dish to dishes list
    // add all ingredients to ingredients list
    // notify listeners
    print("Adding Dish");
    dishes.add(dish);
    for (IngredientWrapper ingredient in dish.ingredients) {
      if (!ingredients.contains(ingredient))
        addIngredient(ingredient.ingredient);
    }
    _persistenceService.encodeDishes(dishes);
    notifyListeners();
  }

  void addDishToMenu(Menu menu, DishWrapper dishWrapper) {
    menu.addDish(dishWrapper);
    addDish(dishWrapper.dish); // this will call notify listeners
    _persistenceService.encodeMenus(menus);
  }

  void addIngredient(Ingredient ingredient) {
    // check if ingredient exists
    // if not
    // add it to the ingredients list
    // encode ingredients
    // notify listeners
    print("Adding Ingredient");
    ingredients.add(ingredient);
    _persistenceService.encodeIngredients(ingredients);
    notifyListeners();
  }

  void addIngredientToDish(Dish dish, IngredientWrapper ingredientWrapper) {
    dish.addIngredient(ingredientWrapper);
    addIngredient(
        ingredientWrapper.ingredient); // this will call notify listeners
  }

  void addToShoppingList(IngredientWrapper ingredient) {
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
    notifyListeners();
  }

  void removeDish(Dish dish) {
    print("Removing Dish");
    dishes.remove(dish);
    _persistenceService.encodeDishes(dishes);
    notifyListeners();
  }

  void removeIngredient(Ingredient ingredient) {
    print("Removing Ingredient");
    ingredients.remove(ingredient);
    _persistenceService.encodeIngredients(ingredients);
    notifyListeners();
  }

  void updateMenus() {
    _persistenceService.encodeMenus(menus);
    notifyListeners();
  }

  void updateDishes() {
    _persistenceService.encodeDishes(dishes);
    notifyListeners();
  }

  void updateIngredients() {
    _persistenceService.encodeIngredients(ingredients);
    notifyListeners();
  }
}
