import 'package:flutter/material.dart';
import 'package:get_that_bread/model/dish/widgets/ingredient_wrapper.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:provider/provider.dart';

class ItemBar extends StatelessWidget {
  final IngredientWrapper ingredientWrapper;
  ItemBar(this.ingredientWrapper);

  @override
  Widget build(BuildContext context) {
    DataService dataService = Provider.of<DataService>(context);
    return Card(
      child: CheckboxListTile(
        title: Text(ingredientWrapper.ingredient.toString()),
        secondary: Text(
          "${ingredientWrapper.count} ${ingredientWrapper.ingredient.unit}",
        ),
        value: ingredientWrapper.checked,
        onChanged: (checked) {
          dataService.checkIngredientOff(ingredientWrapper);
        },
      ),
    );
  }
}
