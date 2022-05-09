import 'package:flutter/material.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/model/dish/widgets/ingredient_wrapper.dart';
import 'package:get_that_bread/model/ingredient/ingredient.dart';
import 'package:get_that_bread/routes/ingredients/edit_ingredients_screen.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:provider/provider.dart';

class SearchIngredientsScreen extends StatefulWidget {
  final Dish _dish;

  SearchIngredientsScreen(this._dish);

  @override
  _SearchIngredientsScreenState createState() =>
      _SearchIngredientsScreenState();
}

class _SearchIngredientsScreenState extends State<SearchIngredientsScreen> {
  List<Ingredient> _ingredients;
  List<Ingredient> _selectedIngredients;
  TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();

    _ingredients = [];

    _selectedIngredients =
        widget._dish.ingredients.map((iw) => iw.ingredient).toList();

    super.initState();
  }

  void _toggleIngredient(Ingredient ingredient) {
    setState(
      () {
        if (_selectedIngredients.contains(ingredient)) {
          _selectedIngredients.remove(ingredient);
        } else {
          _selectedIngredients.add(ingredient);
        }
      },
    );
  }

  void _saveIngredients(DataService dataService) {
    List<IngredientWrapper> newIngredients = _selectedIngredients.map(
      (i) {
        return widget._dish.ingredients.firstWhere(
          (iw) => iw.ingredient == i,
          orElse: () => IngredientWrapper(ingredient: i, count: 1),
        );
      },
    ).toList();

    dataService.addIngredientsToDish(widget._dish, newIngredients);
  }

  @override
  Widget build(BuildContext context) {
    DataService dataService = Provider.of<DataService>(context);
    search(dataService.ingredients);

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
                controller: searchController,
                onChanged: (_) => search(dataService.ingredients),
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
                        .map(
                          (ingredient) => Card(
                            color: _selectedIngredients.contains(ingredient)
                                ? Colors.lightBlueAccent
                                : Colors.white,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4.0),
                            child: InkWell(
                              onTap: () => _toggleIngredient(ingredient),
                              child: ListTile(
                                title: Text(ingredient.name),
                              ),
                            ),
                          ),
                        )
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
                  onPressed: () {
                    _saveIngredients(dataService);
                    Navigator.pop(context);
                  },
                  child: Text("Save Ingredients"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void search(List<Ingredient> ingredients) {
    print("Search Text: " + searchController.text);
    if (searchController.text != "") {
      setState(() {
        _ingredients = ingredients
            .where((element) => element.name.contains(searchController.text))
            .toList();
      });
    } else {
      setState(() {
        _ingredients = ingredients;
      });
    }
  }
}
