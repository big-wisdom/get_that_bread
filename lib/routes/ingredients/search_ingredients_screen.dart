import 'package:flutter/material.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/model/dish/widgets/ingredient_wrapper.dart';
import 'package:get_that_bread/model/ingredient/ingredient.dart';
import 'package:get_that_bread/routes/ingredients/edit_ingredients_screen.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:get_that_bread/widgets/counter.dart';
import 'package:provider/provider.dart';

class SearchIngredientsScreen extends StatefulWidget {
  final Dish _dish;

  SearchIngredientsScreen([this._dish]);

  @override
  _SearchIngredientsScreenState createState() =>
      _SearchIngredientsScreenState();
}

class _SearchIngredientsScreenState extends State<SearchIngredientsScreen> {
  List<Ingredient> _ingredients;
  List<IngredientWrapper> _selectedIngredients;

  @override
  void initState() {
    _ingredients = [];
    if (widget._dish != null) {
      _selectedIngredients = widget._dish.ingredients;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataService dataService = Provider.of<DataService>(context);
    _ingredients = dataService.ingredients;

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Ingredients"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: ("Search here fool"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ..._ingredients
                        .map((ingredient) => Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4.0),
                            child: ListTile(
                              title: Text(ingredient.name),
                              trailing: Counter(),
                            )))
                        .toList(),
                  ],
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                RaisedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new EditIngredientsScreen()),
                    );
                  },
                  label: Text("Add Ingredient"),
                  icon: Icon(Icons.add),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text("Save Ingredients"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
