import 'package:flutter/material.dart';
import 'package:get_that_bread/routes/menus/menus_screen.dart';
import 'package:get_that_bread/routes/shoppingList/shopping_list_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    MenusScreen(),
    ShoppingListScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Menus",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: "Shopping List")
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
