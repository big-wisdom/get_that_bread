import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _counter = 0;
    _controller = new TextEditingController(text: '$_counter');
  }

  void _decrement() {
    setState(() {
      _counter--;
      _controller.text = '$_counter';
    });
  }

  void _increment() {
    setState(() {
      _counter++;
      _controller.text = '$_counter';
    });
  }

  void _updateCounter(String str) {
    setState(() {
      int val = int.parse(str);
      _counter = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: _decrement,
          ),
          Container(
            width: 30.0,
            child: TextField(
              controller: _controller,
              onChanged: _updateCounter,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _increment,
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }
}
