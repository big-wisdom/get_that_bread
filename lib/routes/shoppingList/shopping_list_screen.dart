import 'package:flutter/material.dart';
import 'package:get_that_bread/routes/inventory/inventory.dart';
import 'package:get_that_bread/widgets/counter.dart';

class ShoppingListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping List"),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 100.0),
        shrinkWrap: true,
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text("Eggs"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Milk"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Cheese"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("BREAAAADD"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Milk"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Cheese"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("BREAAAADD"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Milk"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Cheese"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("BREAAAADD"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Milk"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Cheese"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("BREAAAADD"),
              trailing: Counter(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Go Shopping"),
        icon: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Inventory()),
          );
        },
      ),
    );
  }
}
