import 'package:flutter/material.dart';
import 'package:command_app_frontend/res/booking.dart';

class BookingsTable extends StatefulWidget {
  const BookingsTable({super.key});

  @override
  State<BookingsTable> createState() => _BookingsTableState();
}

class _BookingsTableState extends State<BookingsTable> {
  List<Booking> bookingsList = List.empty(growable: true);

  @override
  void initState() {
    bookingsList += getSampleBookings();
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
                          'Data e ora',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      )),
                  DataColumn(
                      label: Expanded(
                        child: Text(
                          'Posti',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      )),
                  DataColumn(
                      label: Expanded(
                        child: Text(
                          'Nome',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      )),
                  DataColumn(
                      label: Expanded(
                        child: Text(
                          'Conferma / Rifiuta',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      )),
                ], rows: [],
                // rows: List<DataRow>.generate(
                //     preparationsList.length,
                //         (index) => DataRow(cells: [
                //       DataCell(
                //           Text(preparationsList[index].dish.name)),
                //       DataCell(
                //           Text(preparationsList[index].tableDeliveryCode)),
                //       DataCell(
                //           Text(preparationsList[index].state.str)),
                //       DataCell(Row(
                //         children: [
                //           IconButton(
                //               onPressed: () => changeState(
                //                   preparationsList[index],
                //                   PreparationState.waiting
                //               ),
                //               icon: const Icon(Icons.watch_later)),
                //           IconButton(
                //               onPressed: () => changeState(
                //                   preparationsList[index],
                //                   PreparationState.underway
                //               ),
                //               icon: const Icon(FontAwesomeIcons.briefcase)),
                //           IconButton(
                //               onPressed: () => changeState(
                //                   preparationsList[index],
                //                   PreparationState.ready
                //               ),
                //               icon: const Icon(Icons.done)),
                //         ],
                //       )),
                //     ]))))
    )));
  }

  // /// change state of 'prep' to 'state', renders to UI
  // void changeState(Preparation prep, PreparationState state){
  //   setState(() => prep.state = state);
  // }
}