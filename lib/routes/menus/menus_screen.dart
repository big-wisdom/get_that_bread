import 'package:flutter/material.dart';
import 'package:get_that_bread/model/dish/dish.dart';
import 'package:get_that_bread/model/menu/menu.dart';
import 'package:get_that_bread/routes/menus/edit_menu_screen.dart';
import 'package:get_that_bread/routes/menus/widgets/dish_card.dart';
import 'package:get_that_bread/services/data_service/data_service.dart';
import 'package:get_that_bread/widgets/counter.dart';
import 'package:provider/provider.dart';

class MenusScreen extends StatefulWidget {
  MenusScreen({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenusScreen> {
  List<Menu> _menus = [];

  void _showDishDetails(BuildContext context, Dish dish) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DishCard(dish);
      },
    );
  }

  void _printDishCounter(int count) {}

  @override
  Widget build(BuildContext context) {
    DataService dataService = Provider.of<DataService>(context);
    _menus = dataService.menus;
    return Scaffold(
      appBar: AppBar(
        title: Text("Menus"),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: _menus.map<ExpansionPanelRadio>(
            (Menu menu) {
              return ExpansionPanelRadio(
                value: menu.id,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    leading: PopupMenuButton(
                      captureInheritedThemes: false,
                      onSelected: (selection) {
                        if (selection == 0) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => new EditMenuScreen(menu),
                            ),
                          );
                        } else if (selection == 1) {
                          dataService.removeMenu(menu);
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          value: 0,
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text("Edit"),
                          ),
                        ),
                        PopupMenuDivider(),
                        PopupMenuItem(
                          value: 1,
                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text("Delete"),
                          ),
                        ),
                      ],
                    ),
                    title: Text(menu.name),
                  );
                },
                body: Column(
                  children: [
                    Divider(),
                    ...menu.dishes
                        .map(
                          (dishWrapper) => ListTile(
                              title: Text(dishWrapper.dish.name),
                              trailing: Counter(dishWrapper.count, (int count) {
                                dishWrapper.count = count;
                                dataService.updateMenus();
                              }),
                              onTap: () =>
                                  _showDishDetails(context, dishWrapper.dish)),
                        )
                        .toList(),
                  ],
                ),
              );
            },
          ).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Add Menu",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => new EditMenuScreen(),
            ),
          );
        },
      ),
    );
  }
}
