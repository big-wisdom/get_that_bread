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

  void _loadEverything() {
    _loadMenus();
    _loadDishes();
    _loadIngredients();
  }

  void _loadMenus() {
    _persistenceService.decodeMenus().then((value) {
      menus = value.map((e) => Menu.fromJson(e));
    });
  }

  void _loadDishes() {
    _persistenceService.decodeDishes().then((value) {
      dishes = value.map((e) => Dish.fromJson(e));
    });
  }

  void _loadIngredients() {
    _persistenceService.decodeIngredients().then((value) {
      ingredients = value.map((e) => Ingredient.fromJson(e));
    });
  }

  void printMenus() {
    _loadMenus();
    print("Menus");
    for (int x = 0; x < menus.length; x++) {
      print(menus[x].name);
    }
  }

  void printDishes() {
    _loadDishes();
    print("Dishes");
    for (int x = 0; x < dishes.length; x++) {
      print(dishes[x].name);
    }
  }

  void printIngredients() {
    _loadIngredients();
    print("Ingredients");
    for (int x = 0; x < ingredients.length; x++) {
      print(ingredients[x].name);
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
