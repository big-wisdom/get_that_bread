import 'package:flutter/material.dart';
import 'package:get_that_bread/routes/inventory/inventory.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:get_that_bread/widgets/counter.dart';
import 'package:provider/provider.dart';

class ShoppingListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataService dataService = Provider.of<DataService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping List"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 100.0),
        shrinkWrap: true,
        itemCount: dataService.shoppingList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title:
                  Text(dataService.shoppingList[index].ingredient.toString()),
              trailing: Counter(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Go Shopping"),
        icon: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Inventory()),
          );
          dataService.populateShoppingList();
        },
      ),
    );
  }
}
