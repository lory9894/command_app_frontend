
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'dart:io';

const String jsonPreparations = """[
{
    "dish": {
      "name": "il Petrone",
      "price": 5.50,
      "description": "panino con prosciutto e mozzarella",
      "imageUrl": "http://www.di.unito.it/~giovanna/gioNew1.jpg",
      "course": "Panino"
    },
    "tableDeliveryCode": "12",
    "state": "ready"
  },
  {
    "dish": {
      "name": "Risotto alla CMRO",
      "price": 5.22,
      "description": "Gvosso risotto per gvossi intenditori (Fakemuscles approves)",
      "imageUrl": "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.researchgate.net%2Fprofile%2FAndrea_Grosso%2F4&psig=AOvVaw3sNpMqQxN08jGPGKzd70v8&ust=1669741417373000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCNjr89Gt0fsCFQAAAAAdAAAAABAE",
      "course": "primo"
    },
    "tableDeliveryCode": "A46",
    "state": "underway"
  }
]
""";


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

enum PreparationState { ready, underway, waiting }

extension PreparationStateStrings on PreparationState {
  String get str {
    switch (this) {
      case PreparationState.waiting:
        return "In attesa";
      case PreparationState.ready:
        return "Pronta";
      case PreparationState.underway:
        return "In preparazione";
    }
  }
}

class Preparation {
  final Dish dish;
  final String tableDeliveryCode;
  PreparationState state;

  Preparation(this.dish, this.tableDeliveryCode,
      {this.state = PreparationState.underway});
}

class PreparationsTable extends StatefulWidget {
  const PreparationsTable({Key? key}) : super(key: key);

  @override
  _PreparationsTableState createState() => _PreparationsTableState();
}

class _PreparationsTableState extends State<PreparationsTable> {
  List<Preparation> preparationsList = List.empty(growable: true);

  @override
  void initState() {
    preparationsList += getPreparationsFromJson(jsonPreparations);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO rendere le righe una reordable list
    return Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
                columnSpacing: 12,
                horizontalMargin: 12,
                columns: const <DataColumn>[
                  DataColumn(
                      label: Expanded(
                    child: Text(
                      'Preparazione',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Text(
                      'Codice',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Text(
                      'Stato',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  )),
                  DataColumn(
                      label: Expanded(
                    child: Text(
                      'Cambia Stato',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  )),
                ],
                rows: List<DataRow>.generate(
                    preparationsList.length,
                    (index) => DataRow(cells: [
                          DataCell(
                              Text(preparationsList[index].dish.name)),
                          DataCell(
                              Text(preparationsList[index].tableDeliveryCode)),
                          DataCell(
                              Text(preparationsList[index].state.str)),
                          DataCell(Row(
                            children: [
                              IconButton(
                                  onPressed: () => changeState(
                                      preparationsList[index],
                                      PreparationState.waiting
                                  ),
                                  icon: const Icon(Icons.watch_later)),
                              IconButton(
                                  onPressed: () => changeState(
                                      preparationsList[index],
                                      PreparationState.underway
                                  ),
                                  icon: const Icon(FontAwesomeIcons.briefcase)),
                              IconButton(
                                  onPressed: () => changeState(
                                      preparationsList[index],
                                      PreparationState.ready
                                  ),
                                  icon: const Icon(Icons.done)),
                            ],
                          )),
                        ]))))
    );
  }

  /// change state of 'prep' to 'state', renders to UI
  void changeState(Preparation prep, PreparationState state){
    setState(() => prep.state = state);
  }

  /// returns list of preparations to show on screen
  List<Preparation> getPreparationsFromJson(String json) {
    // TODO implement reading json and parsing to preparations
    List map = jsonDecode(json);
    print(map);
    for (var prepMap in map) {
      print(prepMap);
      var dishMap = prepMap['dish'];
      Dish dish = Dish(
          name: dishMap['name'],
          description: dishMap['description'],
          price: dishMap['price'],
          course: dishMap['course']
      );

      String prepStateString = prepMap['state'];
      /// preparation state converted from String to Enum
      PreparationState prepState = PreparationState.values.firstWhere(
              (e) => e.toString() == "PreparationState.$prepStateString"
      );
      // TODO course should be converted in enum before assigning to dish
      Preparation prep = Preparation(
          dish,
          prepMap['tableDeliveryCode'],
          state: prepState
      );
      preparationsList.add(prep);
    }
    return List.empty();
  }
}
