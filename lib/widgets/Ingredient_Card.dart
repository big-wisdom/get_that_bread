import 'package:flutter/material.dart';

class IngredientCard extends StatefulWidget {
  final String name;
  final void Function()? onTap;
  const IngredientCard({Key? key, required this.onTap, required this.name})
      : super(key: key);

  @override
  State<IngredientCard> createState() => _IngredientCardState(onTap, name);
}

class _IngredientCardState extends State<IngredientCard> {
  bool highlight = false;
  void Function()? onTap;
  String name;

  _IngredientCardState(this.onTap, this.name);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: highlight ? Colors.lightBlueAccent : Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(name),
        ),
      ),
    );
  }
}
