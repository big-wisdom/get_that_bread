import 'package:flutter/material.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/routes/ingredients/search_ingredients_screen.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:get_that_bread/widgets/counter.dart';
import 'package:provider/provider.dart';

class EditDishScreen extends StatefulWidget {
  final Dish? _dish;

  EditDishScreen([this._dish]);

  @override
  _EditDishScreenState createState() => _EditDishScreenState();
}

enum Status { creating, editing }

class _EditDishScreenState extends State<EditDishScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _dishNameController;
  late TextEditingController _dishDescriptionController;
  late Status status;
  // make working dish here
  Dish _workingDish = Dish("New Dish", "Probably Delicious");

  @override
  void initState() {
    _dishNameController = new TextEditingController();
    _dishDescriptionController = new TextEditingController();

    if (widget._dish == null) {
      status = Status.creating;
    } else {
      status = Status.editing;
      _workingDish = widget._dish!;
      _dishNameController.text = widget._dish!.name;
      _dishDescriptionController.text = widget._dish!.description;
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

  void _saveDish(DataService dataService) {
    // set working dish name
    _workingDish.name = _dishNameController.text;
    // set working dish description
    _workingDish.description = _dishDescriptionController.text;

    dataService.updateOrAddDish(_workingDish);
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
                  if (value != null && value.isEmpty) {
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
                  if (value != null && value.isEmpty) {
                    return 'Please enter a description for your dish.';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 32.0, bottom: 16.0),
                child: Text("Ingredients", style: TextStyle(fontSize: 24.0)),
              ),
              ..._workingDish.ingredients
                  .map(
                    (ingredientWrapper) => Card(
                      child: ListTile(
                        title: Text(ingredientWrapper.ingredient.toString()),
                        trailing: Counter(
                          ingredientWrapper.count,
                          (count) {
                            ingredientWrapper.count = count;
                            dataService.updateMenus();
                          },
                        ),
                      ),
                    ),
                  )
                  .toList(),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          new SearchIngredientsScreen(_workingDish),
                    ),
                  );
                },
                icon: Icon(Icons.add),
                label: Text("Add Ingredient"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 48.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      _saveDish(dataService);
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
