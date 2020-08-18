import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {},
        ),
        Container(
          width: 30.0,
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],

          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        )
      ],
      mainAxisSize: MainAxisSize.min,
    ));
  }
}
