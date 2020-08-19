import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';

void main() {
  runApp(GetThatBread());
}

class GetThatBread extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get That Bread',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final DataService dataService = DataService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get That Bread"),
      ),
      body: Center(
        child: Column(
          children: [
            TypeAheadField(
                suggestionsCallback: (pattern) async {
                  return await dataService.searchIngredients(pattern);
                },
                itemBuilder: (context, dish) => Card(
                      child: Text("${dish.name}"),
                    ),
                onSuggestionSelected: (dish) {
                  debugPrint("Dish Selected ${dish.id}");
                }),
            RaisedButton(
              onPressed: () => dataService.addDish(Dish("Hamburgers")),
              child: Text("Add Hamburgers"),
            ),
            RaisedButton(
              onPressed: () => dataService.addDish(Dish("Pasta")),
              child: Text("Add Pasta"),
            ),
          ],
        ),
      ),
    );
  }
}
