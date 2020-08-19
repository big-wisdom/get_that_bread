import 'package:flutter/material.dart';
import 'package:get_that_bread/routes/menus/edit_menus_screen.dart';
import 'package:get_that_bread/routes/menus/widgets/dish.dart';
import 'package:get_that_bread/routes/menus/widgets/dish_card.dart';
import 'package:get_that_bread/routes/menus/widgets/menu.dart';

class MenusScreen extends StatefulWidget {
  MenusScreen({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenusScreen> {
  List<Menu> _menus = generateMenus(5);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menus"),
      ),
      body: ListView(children: [
        ..._menus
            .map(
              (menu) => ExpansionTile(
                title: Row(children: [
                  Expanded(
                    child: Text(menu.name),
                  ),
                  IconButton(
                    color: Colors.black.withOpacity(0.6),
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  )
                ]),
                children: [
                  ...menu.dishes
                      .map(
                        (dish) => ListTile(
                            title: Text(dish.name),
                            onTap: () => _showDishDetails(context, dish)),
                      )
                      .toList(),
                ],
                childrenPadding: EdgeInsets.only(left: 16.0),
                backgroundColor: Color.fromRGBO(225, 225, 225, 1.0),
              ),
            )
            .toList(),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.all(16.0),
          child: FlatButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => new EditMenusScreen()),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add),
                Text("Add Menu"),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
