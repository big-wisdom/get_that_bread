import 'package:flutter/material.dart';
import 'package:get_that_bread/model/menu/menu.dart';
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
            RaisedButton(
              onPressed: dataService.printMenus,
              child: Text("Print Menus"),
            ),
            RaisedButton(
              onPressed: () => dataService.addMenu(Menu("Budget")),
              child: Text("Add Menu"),
            )
          ],
        ),
      ),
    );
  }
}
