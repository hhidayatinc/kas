import 'package:flutter/material.dart';
import 'package:kas/screens/beranda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const Beranda(),
      debugShowCheckedModeBanner: false,
    );
  }
}