import 'package:command_app_frontend/screens/shopping_cart.dart';
import 'package:flutter/material.dart';

import 'global.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //TODO: DEBUG RIMUOVERE
  @override
  void initState() {
    order.addDish(Dish(
        name: "il Petrone",
        description: "vabbeh",
        price: 5.50,
        course: "panino",
        imageUrl: "http://www.di.unito.it/~giovanna/gioNew1.jpg"));
    order.addDish(Dish(
        name: "il Petrino",
        description: "vabbeh",
        price: 5.50,
        course: "panino",
        imageUrl: "http://www.di.unito.it/~giovanna/gioNew1.jpg"));
    order.addDish(Dish(
        name: "il Petruzzo",
        description: "vabbeh",
        price: 5.50,
        course: "panino",
        imageUrl: "http://www.di.unito.it/~giovanna/gioNew1.jpg"));
    order.addDish(Dish(
        name: "il Petrazzo",
        description: "vabbeh",
        price: 5.50,
        course: "panino",
        imageUrl: "http://www.di.unito.it/~giovanna/gioNew1.jpg"));
    order.addDish(Dish(
        name: "Coppo Divino",
        description: "vino",
        price: 7,
        course: "bevanda"));
    order.addDish(Dish(
        name: "il Petroneeeeeeee",
        description: "vabbeh",
        price: 5.50,
        course: "panino",
        imageUrl: "http://www.di.unito.it/~giovanna/gioNew1.jpg"));
    order.addDish(Dish(
        name: "il Pdfasfetrone",
        description: "vabbeh",
        price: 5.50,
        course: "panino",
        imageUrl: "http://www.di.unito.it/~giovanna/gioNew1.jpg"));
    order.addDish(Dish(
        name: "il fadgePetrone",
        description: "vabbeh",
        price: 5.50,
        course: "panino",
        imageUrl: "http://www.di.unito.it/~giovanna/gioNew1.jpg"));
    order.addDish(Dish(
        name: "il Petroneoneone",
        description: "vabbeh",
        price: 5.50,
        course: "panino",
        imageUrl: "http://www.di.unito.it/~giovanna/gioNew1.jpg"));
    order.tableID = "T1";
    print(order.shoppingCart);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShoppingCart();
  }
}
