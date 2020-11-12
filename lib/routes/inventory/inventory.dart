import 'package:flutter/material.dart';
import 'package:get_that_bread/model/dish/widgets/ingredient_wrapper.dart';
import 'package:get_that_bread/routes/inventory/widgets/inventory_card.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:provider/provider.dart';

class Inventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataService dataService = Provider.of<DataService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Take Inventory"),
      ),
      body: ListView.builder(
        itemCount: dataService.inventory.length,
        padding: EdgeInsets.only(bottom: 100.0),
        itemBuilder: (context, index) {
          IngredientWrapper inventoryItem = dataService.inventory[index];
          return InventoryCard(inventoryItem, dataService);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Finalize List"),
        icon: Icon(Icons.check)
      ),
    );
  }
}
