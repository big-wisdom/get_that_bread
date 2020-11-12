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
  TextEditingController _ingredientNameController;
  Status status;

  void _updateName(String str) {
    setState(() {
      _ingredientNameController.text = str;
    });
  }


  @override
  void initState() {
    _ingredientNameController = new TextEditingController();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _ingredientNameController,
                onFieldSubmitted: _updateName,
                decoration: InputDecoration(labelText: 'Ingredient Name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a ingredient name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.pop(context);
                    dataService.addIngredient(Ingredient(_ingredientNameController.text));
                  }
                },
                child: Text('Save Ingredient'),
              ),
            ),
          ]
        )
      )
    );
  }
}
