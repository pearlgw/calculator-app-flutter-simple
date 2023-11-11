// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_calculator/calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(
        primaryColor: Colors.amber
      ),
      home: Calculator(),
    );
  }
}