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
        padding: const EdgeInsets.all(0),
        width: double.infinity,
        height: double.infinity,
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
                          DataCell(Text(preparationsList[index].state.str)),
                          DataCell(Row(
                            children: const [
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.account_balance)),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.account_balance)),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.account_balance)),
                            ],
                          )),
                        ]))))
    );

    // throw UnimplementedError();

    // return Table(
    //     border: TableBorder.all(),
    //     columnWidths: const <int, TableColumnWidth>{
    //       0: FractionColumnWidth(35),
    //       1: FractionColumnWidth(10),
    //       2: FractionColumnWidth(20),
    //       3: FractionColumnWidth(35),
    //       // continua da qui, devi mettere i dati ma le dimensioni delle colonne sono giuste (credo)
    //     },
    //     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    //     children: <TableRow>[
    //       TableRow(
    //         children: <Widget>[
    //           Container(
    //             height: double.infinity,
    //             color: Colors.green,
    //           ),
    //           TableCell(
    //             verticalAlignment: TableCellVerticalAlignment.top,
    //             child: Container(
    //               height: double.infinity,
    //               color: Colors.red,
    //             ),
    //           ),
    //           Container(
    //             height: double.infinity,
    //             color: Colors.blue,
    //           ),
    //           Container(
    //             color: Colors.blue,
    //           ),
    //         ],
    //       ),
    //       TableRow(
    //         decoration: const BoxDecoration(
    //           color: Colors.grey,
    //         ),
    //         children: <Widget>[
    //           Container(
    //             color: Colors.purple,
    //           ),
    //           Container(
    //             color: Colors.yellow,
    //           ),
    //           Container(
    //             color: Colors.yellow,
    //           ),
    //           Center(
    //             child: Container(
    //               color: Colors.orange,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   );

    // return ListView.builder(
    //   //find the number of different courses in list dishes
    //
    //   itemCount: _dishes_courses().length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return ExpansionTile(
    //       //title : course name white text
    //       title: Text(
    //         _dishes_courses().elementAt(index),
    //       ),
    //       //background color of the tile when closed
    //       collapsedBackgroundColor: Theme.of(context).backgroundColor,
    //
    //       children: dishes
    //           .where(
    //               (dish) => dish.course == _dishes_courses().elementAt(index))
    //           .map((dish) => ListTile(
    //                 tileColor: Colors.white,
    //                 leading: CircleAvatar(
    //                   backgroundImage: dish.imageUrl != null
    //                       ? NetworkImage(dish.imageUrl!)
    //                       : null,
    //                   child: dish.imageUrl == null ? Text(dish.name[0]) : null,
    //                 ),
    //                 title: Text(dish.name),
    //                 subtitle: Text("${dish.description} - ${dish.price}€"),
    //                 trailing: const Icon(Icons.add),
    //               ))
    //           .toList(),
    //     );
    //   },
    // );
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
