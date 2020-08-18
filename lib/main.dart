import 'package:flutter/material.dart';

void main() {
  runApp(GetThatBread());
}

class GetThatBread extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get That Bread"),
      ),
      body: Center(child: Text("Here we go!")),
    );
  }
}
