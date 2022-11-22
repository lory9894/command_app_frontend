import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dish {
  final String name;
  final String description;
  final double price;
  final String? imageUrl;
  final String course;

  Dish(
      {required this.name,
      required this.description,
      required this.price,
      this.imageUrl,
      required this.course});
}

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Dish> dishes = List.empty(growable: true);
  Set<String>? courses;

  @override
  void initState() {
    readJson();
    super.initState();
  }

  void readJson() async {
    var json = """ 
    [
  {
    "name": "il Petrone",
    "price": 5.50,
    "description": "panino con prosciutto e mozzarella",
    "imageUrl": "faioeghd",
    "course": "Panino"
  },
  {
    "name": "Coppo di Vino",
    "price": 100.00,
    "description": "vino rosso",
    "imageUrl": "faioeghd",
    "course": "Bevanda"
  },
    {
        "name": "CapecchiCola",
        "price": 100.00,
        "description": "hoha hola",
        "imageUrl": null,
        "course": "Bevanda"
    }

]
""";
    // to make it work https://stackoverflow.com/questions/65630743/how-to-solve-flutter-web-api-cors-error-only-with-dart-code
    // then python -m http.server 8080 in the folder that contains dummy_dishes.json
    http.get(Uri.http("localhost:8080", "dummy_dishes.json")).then((value) => {
          setState(() {
            dishes = (jsonDecode(value.body) as List)
                .map((e) => Dish(
                    name: e["name"],
                    description: e["description"],
                    price: e["price"],
                    imageUrl: e["imageUrl"],
                    course: e["course"]))
                .toList();
            courses = dishes.map((e) => e.course).toSet();
          }),
          dishes.forEach((element) => print(element.name))
        });
  }

  //if the list of courses is not provided, it will be generated from the list of dishes
  Set<String> _dishes_courses() {
    courses ??= dishes.map((dish) => dish.course).toSet();
    return courses!;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //find the number of different courses in list dishes

      itemCount: _dishes_courses().length,
      itemBuilder: (BuildContext context, int index) {
        return ExpansionTile(
          title: Text(_dishes_courses().elementAt(index)),
          children: dishes
              .where(
                  (dish) => dish.course == _dishes_courses().elementAt(index))
              .map((dish) => ListTile(
                    title: Text(dish.name),
                    subtitle: Text(dish.description),
                    // trailing: Text("${dish.price}€"),
                    trailing: const Icon(Icons.add),
                  ))
              .toList(),
        );
      },
    );
  }
}
