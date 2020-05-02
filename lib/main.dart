import 'package:flutter/material.dart';
import 'package:flutter_map_app/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Map',
      home: HomePage(),
    );
  }
}