import 'package:command_app_frontend/res/booking.dart';
import 'package:flutter/material.dart';

class BookingsTable extends StatefulWidget {
  const BookingsTable({super.key});

  @override
  State<BookingsTable> createState() => _BookingsTableState();
}

class _BookingsTableState extends State<BookingsTable> {
  List<Booking> bookingsList = List.empty(growable: true);
  List<TextEditingController> _tableControllerList = List.empty(growable: true);

  @override
  void initState() {
    bookingsList += getSampleBookings();
    for (var i = 0; i < bookingsList.length; i++) {
      _tableControllerList.add(TextEditingController());
    }
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
                      'Tavolo',
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
                          DataCell(TextField(
                            controller: _tableControllerList[
                                bookingsList.indexOf(booking)],
                          )),
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
    String table = _tableControllerList[bookingsList.indexOf(booking)].text;
    if (table == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Inserisci il numero del tavolo prima di confermare")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Prenotazione confermata per il tavolo $table")));
      setState(() {
        // should send API request to accept booking
        bookingsList.remove(booking);
      });
    }
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
