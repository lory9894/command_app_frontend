import 'package:flutter/material.dart';
import 'dart:convert';

import '../res/dish.dart';
import '../res/preparation.dart';

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
    "state": "brought"
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
    "state": "toBring"
  }
]
""";

class ServiceTable extends StatefulWidget {
  const ServiceTable({Key? key}) : super(key: key);

  @override
  _ServiceTableState createState() => _ServiceTableState();
}

class _ServiceTableState extends State<ServiceTable> {
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
                          // TODO when changing preparation state to "brought" it should be removed after animation. No preparations with served state "brought" be displayed in this table.
                          DataCell(Row(
                            children: [
                              IconButton(
                                  onPressed: () => changeState(
                                      preparationsList[index],
                                      PreparationState.toBring
                                  ),
                                  icon: const Icon(Icons.watch_later)
                              ),
                              IconButton(
                                  onPressed: () => changeState(
                                      preparationsList[index],
                                      PreparationState.brought
                                  ),
                                  icon: const Icon(Icons.done)
                              ),
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
    List map = jsonDecode(json);
    for (var prepMap in map) {
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
