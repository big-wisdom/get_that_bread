import 'package:flutter/material.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/model/menu/menu.dart';
import 'package:get_that_bread/model/menu/widgets/dish_wrapper.dart';
import 'package:get_that_bread/routes/dish/edit_dish_screen.dart';
import 'package:get_that_bread/routes/menus/widgets/dish_card.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:provider/provider.dart';

class EditMenuScreen extends StatefulWidget {
  final Menu _menu;

  EditMenuScreen([this._menu]);

  @override
  _EditMenusScreenState createState() => _EditMenusScreenState();
}

enum Status { creating, editing }

class _EditMenusScreenState extends State<EditMenuScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Dish> _dishes;
  List<Dish> _selectedDishes;
  TextEditingController _menuNameController;
  Status status;

  @override
  void initState() {
    _menuNameController = new TextEditingController();

    if (widget._menu == null) {
      status = Status.creating;
      _selectedDishes = [];
    } else {
      status = Status.editing;
      _selectedDishes =
          widget._menu.dishes.map((wrapper) => wrapper.dish).toList();
      _menuNameController.text = widget._menu.name;
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
    widget._menu.name = _menuNameController.text; // edit name
    widget._menu.dishes = _selectedDishes.map(
      (dish) {
        // edit dishes
        return widget._menu.dishes.firstWhere(
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
            : Text("Edit Menu"),
      ),
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
              child: _dishes.isEmpty
                  ? Center(
                      child: Text("You Have No Meals Yet! Create Some!"),
                    )
                  : ListView.builder(
                      itemCount: _dishes.length,
                      itemBuilder: (context, index) {
                        Dish dish = _dishes[index];
                        return ListTile(
                          title: Text(dish.name),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {},
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: OutlineButton(
                child: Text("Add Dish To Menu"),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: OutlineButton(
                child: Text("Create New Dish"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditDishScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
