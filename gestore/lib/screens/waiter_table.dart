import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../res/preparation.dart';

class ServiceTable extends StatefulWidget {
  const ServiceTable({Key? key}) : super(key: key);

  @override
  _ServiceTableState createState() => _ServiceTableState();
}

class _ServiceTableState extends State<ServiceTable> {
  List<Preparation> preparationsList = List.empty(growable: true);
  static String BASE_URL = 'http://localhost:8080/waiter/preparations';
  late Timer timer;

  @override
  void initState() {
    super.initState();
    //run once before loading the page
    fetchPreparations();
    //then run every second
    timer =
        Timer.periodic(Duration(seconds: 1), (Timer t) => fetchPreparations());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
                            DataCell(Text(preparationsList[index].name)),
                            DataCell(Text(preparationsList[index].table)),
                            DataCell(Text(preparationsList[index].state.str)),
                            DataCell(
                              Center(
                                child: IconButton(
                                    onPressed: () => changeState(
                                        preparationsList[index],
                                        PreparationState.DELIVERED),
                                    icon: const Icon(Icons.done)),
                              ),
                            )
                          ],
                        )))));
  }

  void fetchPreparations() async {
    final response = await http.get(Uri.parse(BASE_URL));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final prepList = jsonDecode(response.body);
      setState(() {
        preparationsList = prepList
            .map<Preparation>((prep) => Preparation.fromJson(prep))
            .toList();
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load preparations');
    }
  }

  /// change state of 'prep' to 'state', renders to UI
  void changeState(Preparation prep, PreparationState state) async {
    final response = await http.put(
        Uri.parse("$BASE_URL/state/${state.name.toLowerCase()}/${prep.id}"));

    if (response.statusCode == 200) {
      fetchPreparations();
    } else {
      print(response.body);
      throw Exception('Failed to change state');
    }
  }
}
