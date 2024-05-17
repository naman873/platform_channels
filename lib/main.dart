import 'package:flutter/material.dart';
import 'package:platform_channels_example/screens/type_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Method Channel Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TypeScreen(),
    );
  }
}
