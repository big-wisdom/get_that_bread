import 'package:flutter/material.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/model/menu/menu.dart';
import 'package:get_that_bread/model/menu/widgets/dish_wrapper.dart';
import 'package:get_that_bread/routes/dish/edit_dish_screen.dart';
import 'package:get_that_bread/routes/menus/widgets/dish_card.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:provider/provider.dart';

class EditMenuScreen extends StatefulWidget {
  final Menu? _menu;

  EditMenuScreen(Menu? menu) : _menu = menu;

  @override
  _EditMenusScreenState createState() => _EditMenusScreenState();
}

enum Status { creating, editing }

class _EditMenusScreenState extends State<EditMenuScreen> {
  final _formKey = GlobalKey<FormState>();
  late List<Dish> _dishes;
  late List<Dish> _selectedDishes;
  late TextEditingController _menuNameController;
  late Status status;

  @override
  void initState() {
    _menuNameController = new TextEditingController();

    if (widget._menu == null) {
      status = Status.creating;
      _selectedDishes = [];
    } else {
      status = Status.editing;
      _selectedDishes =
          widget._menu!.dishes.map((wrapper) => wrapper.dish).toList();
      _menuNameController.text = widget._menu!.name;
    }

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

  void _toggleDish(Dish dishWrapper) {
    setState(
      () {
        if (_selectedDishes.contains(dishWrapper)) {
          _selectedDishes.remove(dishWrapper);
        } else {
          _selectedDishes.add(dishWrapper);
        }
      },
    );
  }

  void _saveMenu(DataService dataService) {
    if (status == Status.creating) {
      Menu myMenu = Menu(_menuNameController.text);
      myMenu.dishes = _selectedDishes
          .map((dish) => DishWrapper(count: 1, dish: dish))
          .toList();
      dataService.addMenu(myMenu);
    } else {
      _editMenu();
      dataService.updateMenus();
    }
  }

  void _editMenu() {
    widget._menu!.name = _menuNameController.text; // edit name
    widget._menu!.dishes = _selectedDishes.map(
      (dish) {
        // edit dishes
        return widget._menu!.dishes.firstWhere(
            (existingDish) => existingDish.dish == dish,
            orElse: () => DishWrapper(
                dish: dish, count: 1)); // check if dish already existed
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    DataService dataService = Provider.of<DataService>(context);
    _dishes = dataService.dishes;
    return Scaffold(
      appBar: AppBar(
          title: (status == Status.creating)
              ? Text("Create New Menu")
              : Text("Edit Menu")),
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
                  if (value != null && value.isEmpty) {
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
              child: _dishes.isEmpty
                  ? Center(child: Text("You Have No Dishes Yet!"))
                  : GridView.extent(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      shrinkWrap: true,
                      maxCrossAxisExtent: 200.0,
                      children: [
                        ..._dishes
                            .map(
                              (dish) => Card(
                                color: (_selectedDishes.contains(dish))
                                    ? Colors.lightBlueAccent
                                    : Colors.white,
                                child: InkWell(
                                  onTap: () => _toggleDish(dish),
                                  onLongPress: () =>
                                      _showDishDetails(context, dish),
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
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditDishScreen()));
                },
                child: Text('Create Dish'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    _saveMenu(dataService);
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
