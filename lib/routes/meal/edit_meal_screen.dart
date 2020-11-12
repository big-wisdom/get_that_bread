// import 'package:flutter/material.dart';
// import 'package:get_that_bread/model/meal/meal.dart';
// import 'package:get_that_bread/services/data_service/data_service.dart';
//
//
// class EditMealScreen extends StatefulWidget {
//   final Meal _meal;
//
//   EditMealScreen([this._meal]);
//
//   @override
//   _EditMealScreenState createState() => _EditMealScreenState();
// }
//
// enum Status { creating, editing }
//
// class _EditMealScreenState extends State<EditMealScreen> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _mealNameController;
//   Status status;
//
//   Meal _workingMeal = Meal("New Meal");
//
//   @override
//   void initState() {
//     _mealNameController = new TextEditingController();
//
//     if (widget._meal == null) {
//       status = Status.creating;
//     } else {
//       status = Status.editing;
//       _workingMeal = widget._meal;
//       _mealNameController.text = widget._meal.name;
//     }
//
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _mealNameController.dispose();
//     super.dispose();
//   }
//
//   void _updateName(String str) {
//     setState(() {
//       _mealNameController.text = str;
//     });
//   }
//
//   Meal _saveMeal(DataService dataService) {
//     // set working meal name
//     _workingMeal.name = _mealNameController.text;
//
//     //dataservice.updateOrAddMeal(_workingMeal);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
//
// }