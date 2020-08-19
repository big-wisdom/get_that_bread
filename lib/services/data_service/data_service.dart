import 'package:flutter/foundation.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/model/ingredient/ingredient.dart';
import 'package:get_that_bread/model/menu/menu.dart';
import 'package:get_that_bread/services/persistence_service/persistence_service.dart';

// this will control a list of Menus, list of Dishes, and list of Ingredients
class DataService {
  final PersistenceService _persistenceService = PersistenceService();
  List<Menu> menus = [];
  List<Dish> dishes = [];
  List<Ingredient> ingredients = [];

  DataService() {
    _loadEverything();
  }

  void populateShoppingList() {
    print("Populating Shopping List");
  }

  void _loadEverything() {
    _loadMenus();
    _loadDishes();
    _loadIngredients();
  }

  Future<void> _loadMenus() async {
    final result = await _persistenceService.decodeMenus();
    menus = result.map((e) => Menu.fromJson(e)).toList();
  }

  Future<void> _loadDishes() async {
    final result = await _persistenceService.decodeDishes();
    dishes = result.map((e) => Dish.fromJson(e)).toList();
  }

  Future<void> _loadIngredients() async {
    final result = await _persistenceService.decodeIngredients();
    ingredients = result.map((e) => Ingredient.fromJson(e)).toList();
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

  void addMenu(Menu menu) {
    print("Adding Menu");
    menus.add(menu);
    _persistenceService.encodeMenus(menus);
  }

  void addDish(Dish dish) {
    print("Adding Dish");
    dishes.add(dish);
    _persistenceService.encodeDishes(dishes);
  }

  void addIngredient(Ingredient ingredient) {
    print("Adding Ingredient");
    ingredients.add(ingredient);
    _persistenceService.encodeIngredients(ingredients);
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
