import 'package:flutter/material.dart';
import 'package:get_that_bread/model/dish/widgets/ingredient_wrapper.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:get_that_bread/widgets/adaptable_text.dart';
import 'package:get_that_bread/widgets/counter.dart';

class InventoryCard extends StatefulWidget {
  final IngredientWrapper _inventoryItem;
  final DataService _dataService;
  InventoryCard(this._inventoryItem, this._dataService);

  @override
  _InventoryCardState createState() => _InventoryCardState();
}

class _InventoryCardState extends State<InventoryCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.texture),
        ),
        Expanded(
          child: AdaptableText(
            widget._inventoryItem.ingredient.name,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Counter(
          widget._inventoryItem.count,
          (count) {
            widget._inventoryItem.count = count;
            widget._dataService.calculateShoppingList();
            widget._dataService.callNotifyListeners();
          },
        ),
        SizedBox(
          width: 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AdaptableText(widget._inventoryItem.ingredient.unit),
          ),
        ),
      ],
    );
  }
}
