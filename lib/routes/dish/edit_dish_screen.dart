import 'package:flutter/material.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/routes/ingredients/search_ingredients_screen.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:provider/provider.dart';

class EditDishScreen extends StatefulWidget {
  final Dish _dish;

  EditDishScreen([this._dish]);

  @override
  _EditDishScreenState createState() => _EditDishScreenState();
}

enum Status { creating, editing }

class _EditDishScreenState extends State<EditDishScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _dishNameController;
  TextEditingController _dishDescriptionController;
  Status status;

  @override
  void initState() {
    _dishNameController = new TextEditingController();
    _dishDescriptionController = new TextEditingController();

    if (widget._dish == null) {
      status = Status.creating;
    } else {
      status = Status.editing;
      _dishNameController.text = widget._dish.name;
      _dishDescriptionController.text = widget._dish.description;
    }

    super.initState();
  }

  @override
  void dispose() {
    _dishNameController.dispose();
    _dishDescriptionController.dispose();
    super.dispose();
  }

  void _updateName(String str) {
    setState(() {
      _dishNameController.text = str;
    });
  }

  void _updateDescription(String str) {
    setState(() {
      _dishDescriptionController.text = str;
    });
  }

  Dish _createDish() {
    return Dish(_dishNameController.text, _dishDescriptionController.text);
  }

  @override
  Widget build(BuildContext context) {
    DataService dataService = Provider.of<DataService>(context);

    return Scaffold(
      appBar: AppBar(
        title: (status == Status.creating)
            ? Text("Create Dish")
            : Text("Edit Dish"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/meal.png'),
              TextFormField(
                controller: _dishNameController,
                onFieldSubmitted: _updateName,
                decoration: InputDecoration(labelText: 'Dish Name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a dish name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dishDescriptionController,
                onFieldSubmitted: _updateDescription,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a description for your dish.';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 32.0, bottom: 16.0),
                child: Text("Ingredients", style: TextStyle(fontSize: 24.0)),
              ),
              if(status == Status.editing)
                ...widget._dish.ingredients
                    .map(
                      (ingredient) => Card(
                        child: ListTile(
                          title: Text(ingredient.toString()),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new SearchIngredientsScreen()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    Text("Add Ingredient"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 48.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.pop(context);
                      dataService.addDish(_createDish());
                    }
                  },
                  child: Text('Save Dish'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
