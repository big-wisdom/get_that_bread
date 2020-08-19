import 'package:flutter/material.dart';
import 'package:get_that_bread/routes/dish/edit_dish_screen.dart';
import 'package:get_that_bread/routes/menus/widgets/dish.dart';

class DishCard extends StatelessWidget {
  final Dish _dish;

  DishCard([
    this._dish,
  ]);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(4.0, 150.0, 4.0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0))),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('images/meal.png'),
          ListTile(
            title: Text(_dish.name, style: TextStyle(fontSize: 24.0)),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                _dish.description,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditDishScreen(_dish)),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Text("Ingredients", style: TextStyle(fontSize: 20.0)),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                ..._dish.ingredients
                    .map(
                      (ingredient) => Card(
                        child: ListTile(
                          title: Text(ingredient),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
