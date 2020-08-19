import 'package:flutter/material.dart';
import 'package:get_that_bread/routes/menus/widgets/dish.dart';
import 'package:get_that_bread/routes/menus/widgets/dish_card.dart';
import 'package:get_that_bread/routes/menus/widgets/menu.dart';

class EditMenusScreen extends StatefulWidget {
  final Menu _menu;

  EditMenusScreen([
    this._menu,
  ]);

  @override
  _EditMenusScreenState createState() => _EditMenusScreenState();
}

class _EditMenusScreenState extends State<EditMenusScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Dish> _dishes = generateDishes(15);
  List<Dish> _selectedDishes = [];
  TextEditingController _menuNameController;

  @override
  void initState() {
    _menuNameController = new TextEditingController(text: "New Menu");
    super.initState();
  }

  void _updateName(String str) {
    setState(() {
      _menuNameController.text = str;
    });
  }

  void _showDishDetails(BuildContext context, Dish dish) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DishCard(dish);
      },
    );
  }

  void _toggleDish(Dish dish) {
    setState(() {
      if (_selectedDishes.contains(dish)) {
        _selectedDishes.remove(dish);
      } else {
        _selectedDishes.add(dish);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create New Menu")),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _menuNameController,
                onFieldSubmitted: _updateName,
                decoration: InputDecoration(labelText: 'Menu Name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a menu name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Dishes", style: TextStyle(fontSize: 24.0)),
            ),
            Expanded(
              child: GridView.extent(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                shrinkWrap: true,
                maxCrossAxisExtent: 200.0,
                children: [
                  ..._dishes
                      .map(
                        (dish) => Card(
                          color: (_selectedDishes.contains(dish)) ? Colors.lightBlueAccent : Colors.white,
                          child: InkWell(
                            onTap: () => _toggleDish(dish),
                            onLongPress: () => _showDishDetails(context, dish),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      dish.name,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      dish.description,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.pop(context);
                  }
                },
                child: Text('Save Menu'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
