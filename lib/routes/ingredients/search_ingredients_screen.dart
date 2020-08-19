import 'package:flutter/material.dart';

class SearchIngredientsScreen extends StatefulWidget {
  @override
  _SearchIngredientsScreenState createState() =>
      _SearchIngredientsScreenState();
}

class _SearchIngredientsScreenState extends State<SearchIngredientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Ingredients"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: ("Search here fool"),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ListView(shrinkWrap: true, children: [
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: ListTile(
                    title: Text("Chips"),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: ListTile(
                    title: Text("Salsa"),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
