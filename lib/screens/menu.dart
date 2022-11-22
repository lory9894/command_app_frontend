import 'dart:convert';

import 'package:flutter/material.dart';

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
    //var json_online = await http.get(Uri.http("localhost:8080", "dummy_dishes"));
    var dishes_dict = jsonDecode(json);
    dishes_dict.forEach((dish) => dishes.add(Dish(
        name: dish['name'],
        description: dish['description'],
        price: dish['price'],
        imageUrl: dish['imageUrl'],
        course: dish['course'])));
    print(dishes_dict);
    print(dishes);
  }

  //if the list of courses is not provided, it will be generated from the list of dishes
  Set<String> _dishes_courses() {
    courses ??= dishes.map((dish) => dish.course).toSet();
    return courses!;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      //find the number of different courses in list dishes

      itemCount: _dishes_courses().length,
      itemBuilder: (BuildContext context, int index) {
        return ExpansionTile(
          title: Text(_dishes_courses().elementAt(index)),
          children: dishes!
              .where(
                  (dish) => dish.course == _dishes_courses().elementAt(index))
              .map((dish) => ListTile(
                    title: Text(dish.name),
                    subtitle: Text(dish.description),
                    trailing: Text("${dish.price}€"),
                  ))
              .toList(),
        );
      },
    );
  }
}
