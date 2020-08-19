import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter;
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _counter = 0;
    _controller = new TextEditingController(text: _counter.toString());
//    _focusNode = new FocusNode();
//    _focusNode.addListener(() {
//      if (_focusNode.hasFocus) {
//        _controller.selection =
//            TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
//      }
//    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _decrement() {
    setState(() {
      (_counter > 0) ? _counter-- : _counter = 0;
      _controller.text = _counter.toString();
    });
  }

  void _increment() {
    setState(() {
      _counter++;
      _controller.text = _counter.toString();
    });
  }

  void _updateCounter(String str) {
    setState(() {
      _controller.text.isEmpty ? _counter = 0 : _counter = int.parse(str);
      _controller.text = _counter.toString();
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
              focusNode: _focusNode,
              onChanged: _updateCounter,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: null,
              maxLength: 3,
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
