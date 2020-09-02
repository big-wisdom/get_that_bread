import 'package:flutter/material.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:get_that_bread/widgets/counter.dart';
import 'package:provider/provider.dart';

class Inventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataService dataService = Provider.of<DataService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory"),
      ),
      body: ListView.builder(
        itemCount: dataService.inventory.length,
        padding: EdgeInsets.only(bottom: 100.0),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text(dataService.inventory[index].ingredient.toString()),
              trailing: Counter(),
            ),
          );
        },
      ),
    );
  }
}
