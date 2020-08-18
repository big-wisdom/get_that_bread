import 'package:flutter/material.dart';
import 'package:get_that_bread/routes/home.dart';

void main() {
  runApp(GetThatBread());
}

class GetThatBread extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get That Bread',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}


