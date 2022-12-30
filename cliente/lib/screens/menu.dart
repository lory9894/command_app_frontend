import 'dart:convert';

import 'package:command_app_frontend/session.dart';
import 'package:command_app_frontend/widgets/app_bar_login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../custom_classes/dish.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<Dish> dishes = List.empty(growable: true);
  Set<String>? courses;
  static String BASE_URL =
      'http://localhost:8080/menu'; //TODO: add the correct url, not localhost

  @override
  void initState() {
    fetchDishes();
    super.initState();
  }

  void fetchDishes() async {
    var response = await http.get(Uri.parse("$BASE_URL/getDishes"));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //from the response body, get the list of dishes
      dishes = jsonResponse.map<Dish>((json) => Dish.fromJson(json)).toList();
      //find the number of different courses in list dishes
      courses = dishes.map((e) => e.course).toSet();
      setState(() {});
      dishes.forEach((element) {
        print(element);
      }); //TODO: remove thisii
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void readJson() async {
    http.get(Uri.http("$BASE_URL/getDishes")).then((value) => {
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
        });
  }

  //if the list of courses is not provided, it will be generated from the list of dishes
  Set<String> _dishesCourses() {
    courses ??= dishes.map((dish) => dish.course).toSet();
    return courses!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarLogin(),
      body: ListView.builder(
        itemCount: _dishesCourses().length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
            //title : course name white text
            title: Text(
              _dishesCourses().elementAt(index),
            ),
            //background color of the tile when closed
            collapsedBackgroundColor: Theme.of(context).backgroundColor,

            children: dishes
                .where(
                    (dish) => dish.course == _dishesCourses().elementAt(index))
                .map((dish) => ListTile(
                      tileColor: Colors.white,
                      leading: CircleAvatar(
                        backgroundImage: dish.imageUrl != null
                            ? NetworkImage(dish.imageUrl!)
                            : null,
                        child:
                            dish.imageUrl == null ? Text(dish.name[0]) : null,
                      ),
                      title: Text(dish.name),
                      subtitle: Text("${dish.description} - ${dish.price}€"),
                      trailing: IconButton(
                          onPressed: () {
                            order.addDish(dish);
                          },
                          icon: const Icon(Icons.add)),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
