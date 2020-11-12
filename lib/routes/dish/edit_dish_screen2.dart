import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/routes/ingredients/search_ingredients_screen.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:get_that_bread/widgets/counter.dart';
import 'package:provider/provider.dart';

class EditDishScreen2 extends StatefulWidget {
  final Dish _dish;

  EditDishScreen2([this._dish]);

  @override
  _EditDishScreen2State createState() => _EditDishScreen2State();
}

enum Status { creating, editing }

class _EditDishScreen2State extends State<EditDishScreen2> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _dishNameController;
  TextEditingController _dishDescriptionController;
  Status status;

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
      _workingDish = widget._dish;
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

  Dish _saveDish(DataService dataService) {
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
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: Image.asset(
                'images/pancakes.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('List Item $index'),
                  );
                },
              ),
            )
            // Image.asset('images/meal.png'),
            // TextFormField(
            //   controller: _dishNameController,
            //   onFieldSubmitted: _updateName,
            //   decoration: InputDecoration(labelText: 'Dish Name'),
            //   validator: (value) {
            //     if (value.isEmpty) {
            //       return 'Please enter a dish name';
            //     }
            //     return null;
            //   },
            // ),
            // TextFormField(
            //   controller: _dishDescriptionController,
            //   onFieldSubmitted: _updateDescription,
            //   decoration: InputDecoration(labelText: 'Description'),
            //   validator: (value) {
            //     if (value.isEmpty) {
            //       return 'Please enter a description for your dish.';
            //     }
            //     return null;
            //   },
            // ),
            // Padding(
            //   padding: EdgeInsets.only(top: 32.0, bottom: 16.0),
            //   child: Text("Ingredients", style: TextStyle(fontSize: 24.0)),
            // ),
            // ..._workingDish.ingredients
            //     .map(
            //       (ingredientWrapper) => Card(
            //         child: ListTile(
            //           title: Text(ingredientWrapper.ingredient.toString()),
            //           trailing: Counter(
            //             ingredientWrapper.count,
            //             (count) {
            //               ingredientWrapper.count = count;
            //               dataService.updateMenus();
            //             },
            //           ),
            //         ),
            //       ),
            //     )
            //     .toList(),
            // FlatButton.icon(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             new SearchIngredientsScreen(_workingDish),
            //       ),
            //     );
            //   },
            //   icon: Icon(Icons.add),
            //   label: Text("Add Ingredient"),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 48.0),
            //   child: RaisedButton(
            //     onPressed: () {
            //       if (_formKey.currentState.validate()) {
            //         Navigator.pop(context);
            //         _saveDish(dataService);
            //       }
            //     },
            //     child: Text('Save Dish'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
