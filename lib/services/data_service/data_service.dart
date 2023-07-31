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
  List<IngredientWrapper> shoppingList = []; // needed - inventory
  List<IngredientWrapper> checkedOff = []; // checked off the shopping list
  List<IngredientWrapper> needed = []; // list populated from the menu
  List<IngredientWrapper> inventory = []; // what you have at home
  Menu? selectedMenu;

  DataService() {
    _loadEverything();
  }

  void goShopping(Menu? menu) {
    if (menu == null) return;
    // clear shopping list, inventory, and needed (let shopping list page repopulate itself)
    // populate needed and inventory(all set to 0) from the menu
    print("Going Shopping");
    needed = [];
    inventory = [];
    shoppingList = [];
    checkedOff = [];
    for (DishWrapper dishWrapper in menu.dishes) {
      for (IngredientWrapper iw in dishWrapper.dish.ingredients) {
        // if needed already has it, then just combine the count, don't do anything to inventory
        if (needed.contains(iw)) {
          needed[needed.indexOf(iw)].count += (iw.count * dishWrapper.count);
        } else {
          // otherwise add it to needed and inventory(with count 0 for inventory)
          int amountNeeded = dishWrapper.count * iw.count;
          needed.add(
            IngredientWrapper(
                ingredient: iw.ingredient, count: amountNeeded, checked: false),
          );

          print("Adding ${iw.ingredient} to inventory");
          inventory.add(
            IngredientWrapper(
              ingredient: iw.ingredient,
              count: 0,
              checked: false,
            ),
          );
        }
      }
    }
    _persistenceService.encodeShoppingList(shoppingList);
    notifyListeners();
  }

  void calculateShoppingList() {
    print("calculating Shopping list");
    shoppingList = [];
    for (IngredientWrapper need in needed) {
      IngredientWrapper inventoryItem =
          inventory.firstWhere((iw) => iw == need, orElse: () {
        throw Exception(
          "Uh oh! Your needed list doesn't match your inventory list",
        );
      });
      int numberNeeded = need.count - inventoryItem.count;
      shoppingList.add(
        IngredientWrapper(
            ingredient: need.ingredient, count: numberNeeded, checked: false),
      );
    }
  }

  void callNotifyListeners() {
    notifyListeners();
  }

  void clearShoppingList() async {
    shoppingList = [];
    await _persistenceService.encodeShoppingList(shoppingList);
    notifyListeners();
  }

  // move item from shopping list to checkedOff
  void checkIngredientOff(IngredientWrapper iw) {
    // remove item from needed list
    needed.remove(iw);
    // add it to checked off
    checkedOff.add(iw);
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

  // updates dish if it already exists
  // creates it if it doesn't
  Future<void> addDish(Dish dish) async {
    if (dishes.contains(dish)) {
      dishes[dishes.indexOf(dish)] = dish;
    } else {
      dishes.add(dish);
    }

    for (IngredientWrapper ingredient in dish.ingredients) {
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

  // go through all menus to update their versions of a dish
  // go through all dishes to update their versions of a dish
  void updateOrAddDish(Dish dish) {
    _updateDishInMenus(dish);
    addDish(dish);
  }

  void _updateDishInMenus(Dish dish) {
    // search each menu for dish
    for (Menu menu in menus) {
      for (DishWrapper menuDW in menu.dishes) {
        if (menuDW.dish == dish) menuDW.dish = dish; // update it if it exists
      }
    }

    // encode menus
    updateMenus(); // this will call notifyListeners
  }

  void addIngredient(Ingredient ingredient) {
    if (ingredients.contains(ingredient)) {
      ingredients[ingredients.indexOf(ingredient)] = ingredient;
    } else {
      ingredients.add(ingredient);
    }

    _persistenceService.encodeIngredients(ingredients);
    notifyListeners();
  }

  void addIngredientsToDish(Dish dish, List<IngredientWrapper> ingredients) {
    dish.ingredients = ingredients;
    for (IngredientWrapper iw in ingredients) {
      addIngredient(iw.ingredient); // this will call notify listeners
    }
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
                dish as Dish;
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
                ingredient as Ingredient;
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
