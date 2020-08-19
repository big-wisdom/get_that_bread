import 'package:flutter/material.dart';
import 'package:get_that_bread/widgets/counter.dart';

class Inventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory"),
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 100.0),
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("Eggs"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("Milk"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("Cheese"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("BREAAAADD"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("Milk"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("Cheese"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("BREAAAADD"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("Milk"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("Cheese"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("BREAAAADD"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("Milk"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("Cheese"),
              trailing: Counter(),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.texture),
              title: Text("BREAAAADD"),
              trailing: Counter(),
            ),
          ),
        ],
      ),
    );
  }
}
