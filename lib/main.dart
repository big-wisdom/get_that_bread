import 'package:flutter/material.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/model/ingredient/ingredient.dart';
import 'package:get_that_bread/model/menu/menu.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';

void main() {
  runApp(GetThatBread());
}

class GetThatBread extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get That Bread',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final DataService dataService = DataService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get That Bread"),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                RaisedButton(
                  onPressed: dataService.printMenus,
                  child: Text("Print Menus"),
                ),
                RaisedButton(
                  onPressed: () => dataService.addMenu(
                    Menu("Budget")
                      ..addDish(
                        Dish("Pasta")
                          ..addIngredient(Ingredient("Noods"))
                          ..addIngredient(Ingredient("Sauwce")),
                      ),
                  ),
                  child: Text("Add Menu"),
                ),
              ],
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: dataService.printDishes,
                  child: Text("Print Dishes"),
                ),
                RaisedButton(
                  onPressed: () => dataService.addDish(Dish("Pasta")
                    ..addIngredient(Ingredient("noods"))
                    ..addIngredient(Ingredient("Sauuuuce"))),
                  child: Text("Add Dish"),
                ),
              ],
            ),
            Row(
              children: [
                RaisedButton(
                  onPressed: dataService.printIngredients,
                  child: Text("Print Ingredients"),
                ),
                RaisedButton(
                  onPressed: () =>
                      dataService.addIngredient(Ingredient("noods")),
                  child: Text("Add Ingredient"),
                ),
              ],
            ),
            RaisedButton(
              onPressed: dataService.populateShoppingList,
              child: Text("Populate Shopping List"),
            ),
          ],
        ),
      ),
    );
  }
}
