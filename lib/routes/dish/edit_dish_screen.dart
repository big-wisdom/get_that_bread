import 'package:flutter/material.dart';
import 'package:get_that_bread/routes/menus/widgets/dish.dart';

class EditDishScreen extends StatefulWidget {
  final Dish _dish;

  EditDishScreen([
    this._dish,
  ]);

  @override
  _EditDishScreenState createState() => _EditDishScreenState();
}

class _EditDishScreenState extends State<EditDishScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget._dish.name)),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Dish Name'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a dish name';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
