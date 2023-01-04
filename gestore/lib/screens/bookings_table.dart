import 'dart:async';
import 'dart:convert';

import 'package:command_app_frontend/res/booking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookingsTable extends StatefulWidget {
  const BookingsTable({super.key});

  @override
  State<BookingsTable> createState() => _BookingsTableState();
}

class _BookingsTableState extends State<BookingsTable> {
  List<Booking> bookingsList = List.empty(growable: true);
  List<TextEditingController> _tableControllerList = List.empty(growable: true);
  late Timer timer;
  static String BASE_URL =
      'http://localhost:8080/reservation'; //TODO: add the correct url, not localhost

  @override
  void initState() {
    super.initState();
    fetchBookings();

    timer = Timer.periodic(Duration(seconds: 10), (Timer t) => fetchBookings());
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

  Future<void> acceptBooking(Booking booking) async {
    String table = _tableControllerList[bookingsList.indexOf(booking)].text;
    if (table == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Inserisci il numero del tavolo prima di confermare")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Prenotazione confermata per il tavolo $table")));

      final response = await http
          .put(Uri.parse("$BASE_URL/accept/${booking.id}/table/$table"));

      if (response.statusCode == 200) {
        fetchBookings();
      } else {
        print(response.body);
        throw Exception('Failed to change state');
      }
    }
  }

  Future<void> refuseBooking(Booking booking) async {
    // should send API request to refuse booking
    final response =
        await http.put(Uri.parse("$BASE_URL/reject/${booking.id}"));

    if (response.statusCode == 200) {
      fetchBookings();
    } else {
      print(response.body);
      throw Exception('Failed to change state');
    }
  }

  fetchBookings() async {
    final response = await http.get(Uri.parse("$BASE_URL/all/waiting"));
    if (response.statusCode == 200) {
      final bookingJson = jsonDecode(response.body);
      setState(() {
        bookingsList =
            bookingJson.map<Booking>((json) => Booking.fromJson(json)).toList();
        //creates a list of TextEditingControllers, one for each booking to grant the possibility to insert the table number
        for (var i = 0; i < bookingsList.length; i++) {
          _tableControllerList.add(TextEditingController());
        }
      });
    } else {
      throw Exception('Failed to load bookings');
    }
  }
}
