import 'package:flutter/material.dart';
import 'package:get_that_bread/model/ingredient/ingredient.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:provider/provider.dart';

class EditIngredientsScreen extends StatefulWidget {
  @override
  _EditIngredientsScreenState createState() => _EditIngredientsScreenState();
}

enum Status { creating, editing }

class _EditIngredientsScreenState extends State<EditIngredientsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _ingredientNameController;
  late TextEditingController _ingredientUnitController;

  late Status status;

  @override
  void initState() {
    _ingredientNameController = new TextEditingController();
    _ingredientUnitController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataService dataService = Provider.of<DataService>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Create New Ingredient"),
        ),
        body: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _ingredientNameController,
                  decoration: InputDecoration(labelText: 'Ingredient Name'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter a ingredient name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _ingredientUnitController,
                  decoration:
                      InputDecoration(labelText: 'Ingredient Unit of Purchase'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Enter the unit you purchase this item in';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                      dataService.addIngredient(
                        Ingredient(
                          name: _ingredientNameController.text,
                          unit: _ingredientUnitController.text,
                        ),
                      );
                    }
                  },
                  child: Text('Save Ingredient'),
                ),
              ),
            ])));
  }
}
