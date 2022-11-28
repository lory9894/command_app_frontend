import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    preparationsList += getPreparations();
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
  List<Preparation> getPreparations() {
    // TODO implement reading json and parsing to preparations
    // dummy implementation
    Dish dish1 = Dish(
        name: "Il Petrone",
        description: "mi piace il panino di Baldoni gnam",
        price: 6.66,
        course: "panino");
    Dish dish2 = Dish(
        name: "Risotto alla CMRO",
        description: "Gvosso risotto per buongustai (Fakemuscles approves)",
        price: 1.25,
        course: "primo");
    Preparation preparation1 = Preparation(dish1, "1");
    Preparation preparation2 =
        Preparation(dish2, "A46", state: PreparationState.waiting);
    return [preparation1, preparation2];
  }
}
