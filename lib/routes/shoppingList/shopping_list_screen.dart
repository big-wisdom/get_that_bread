import 'package:flutter/material.dart';
import 'package:get_that_bread/model/menu/menu.dart';
import 'package:get_that_bread/routes/inventory/inventory.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:get_that_bread/widgets/counter.dart';
import 'package:provider/provider.dart';

class ShoppingListScreen extends StatefulWidget {
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  Menu selectedMenu;

  void _menuChange(Menu menu, DataService dataService) {
    selectedMenu = menu;
    dataService.selectedMenu = menu;
    dataService.clearShoppingList();
  }

  @override
  Widget build(BuildContext context) {
    DataService dataService = Provider.of<DataService>(context);
    if (dataService.selectedMenu == null) {
      // if selected menu is null
      // try to populate it
      if (dataService.menus.length > 0)
        dataService.selectedMenu = dataService.menus[0];
    }
    selectedMenu = dataService.selectedMenu;

    return Scaffold(
      appBar: AppBar(
        title: selectedMenu == null
            ? Text("No Menus Created Yet!")
            : DropdownButton(
                value: selectedMenu,
                items: dataService.menus
                    .map(
                      (menu) => DropdownMenuItem(
                        value: menu,
                        child: Text(
                          menu.name,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (menu) {
                  setState(() => _menuChange(menu, dataService));
                },
              ),
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
              trailing: Counter(0),
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
          dataService.populateShoppingList(selectedMenu);
        },
      ),
    );
  }
}
