import 'package:command_app_frontend/res/booking.dart';
import 'package:flutter/material.dart';

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
    print(bookingsList);
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
                ],
                rows: bookingsList
                    .map(((booking) => DataRow(cells: <DataCell>[
                          DataCell(Text(booking.getStringDate())),
                          DataCell(Text(booking.seats.toString())),
                          DataCell(Text(booking.userName)),
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () => acceptBooking(booking),
                                  icon: const Icon(Icons.check)),
                              IconButton(
                                  onPressed: () => refuseBooking(booking),
                                  icon: const Icon(Icons.close)),
                            ],
                          ))
                        ])))
                    .toList())));
  }

  void acceptBooking(Booking booking) {
    // should send API request to accept booking
    setState(() {
      bookingsList.remove(booking);
    });
  }

  void refuseBooking(Booking booking) {
    // should send API request to refuse booking
    setState(() {
      bookingsList.remove(booking);
    });
  }

  // /// change state of 'prep' to 'state', renders to UI
  // void changeState(Preparation prep, PreparationState state){
  //   setState(() => prep.state = state);
  // }
}
