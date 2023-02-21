// app color palette: Orange (#ffb238), Green (#448a66)

import 'package:command_app_frontend/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CommandApp',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFffb238),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(secondary: const Color(0xFF448a66)),
      ),
      home: const AdminHomePage(),
    );
  }
}
