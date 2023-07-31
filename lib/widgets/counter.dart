import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Counter extends StatefulWidget {
  final int startingCount;
  final void Function(int count) _onCounterUpdate;

  Counter(this.startingCount, this._onCounterUpdate);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late int _counter;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _counter = widget.startingCount;
    _controller = new TextEditingController(text: _counter.toString());
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
    widget._onCounterUpdate(_counter);
  }

  void _increment() {
    setState(() {
      _counter++;
      _controller.text = _counter.toString();
    });
    widget._onCounterUpdate(_counter);
  }

  void _updateCounter(bool hasFocus) {
    setState(() {
      if (!hasFocus) {
        if (_controller.text.isEmpty) {
          _controller.text = '0';
        }
        _counter = int.parse(_controller.text);
      } else {
        _controller.selection =
            TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
      }
    });
    widget._onCounterUpdate(_counter);
  }

  void setCount(int count) {
    setState(() {
      _counter = count;
      _controller.text = count.toString();
    });
  }

  int getCount() {
    return _counter;
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
            child: Focus(
              onFocusChange: _updateCounter,
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: null,
                maxLength: 3,
              ),
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
