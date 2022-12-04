import 'package:flutter/material.dart';

import '../res/preparation.dart';

class ServiceTable extends StatefulWidget {
  const ServiceTable({Key? key}) : super(key: key);

  @override
  _ServiceTableState createState() => _ServiceTableState();
}

class _ServiceTableState extends State<ServiceTable> {
  List<Preparation> preparationsList = List.empty(growable: true);

  @override
  void initState() {
    preparationsList += getSamplePreparations();
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
                    (index) => DataRow(
                          cells: [
                            DataCell(Text(preparationsList[index].dish.name)),
                            DataCell(Text(
                                preparationsList[index].tableDeliveryCode)),
                            DataCell(Text(preparationsList[index].state.str)),
                            DataCell(
                              IconButton(
                                  onPressed: () => changeState(
                                      preparationsList[index],
                                      PreparationState.brought),
                                  icon: const Icon(Icons.done)),
                            )
                          ],
                        )))));
  }

  /// change state of 'prep' to 'state', renders to UI
  void changeState(Preparation prep, PreparationState state) {
    if (state == PreparationState.brought) {
      // preparation state set to brought, remove from preparation table
      prep.state = state;
      setState(() {
        preparationsList.remove(prep);
      });
    } else {
      // show new preparation state
      setState(() {
        prep.state = state;
      });
    }
  }
}
