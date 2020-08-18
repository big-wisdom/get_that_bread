import 'package:flutter/material.dart';
import 'package:get_that_bread/routes/shoppingList/widgets/counter.dart';

class ShoppingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping List"),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          Card(
            child: ListTile(
                leading: Icon(Icons.texture),
                title: Text("Eggs"),
                trailing: Counter()),
          ),
        ]),
      ),
    );
  }
}
