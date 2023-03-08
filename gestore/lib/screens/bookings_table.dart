import 'dart:async';
import 'dart:convert';

import 'package:command_app_frontend/res/booking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/app_bars.dart';

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
    return Scaffold(
      appBar: const AppBarComandapp(),
      body: Column(
        children: [
          //padding
          const SizedBox(
            height: 20,
          ),
          // title
          Container(
              alignment: Alignment.topCenter,
              child: Text(
                'Prenotazioni',
                style: Theme.of(context).textTheme.headline1,
              )),
          //padding
          const SizedBox(
            height: 20,
          ),
          // table
          Container(
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
                      .toList()))),
        ],
      ),
    );
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

  // fetchBookings() async {
  //   final response = await http.get(Uri.parse("$BASE_URL/all/waiting"));
  //   if (response.statusCode == 200) {
  //     final bookingJson = jsonDecode(response.body);
  //     setState(() {
  //       bookingsList =
  //           bookingJson.map<Booking>((json) => Booking.fromJson(json)).toList();
  //       //creates a list of TextEditingControllers, one for each booking to grant the possibility to insert the table number
  //       for (var i = 0; i < bookingsList.length; i++) {
  //         _tableControllerList.add(TextEditingController());
  //       }
  //     });
  //   } else {
  //     throw Exception('Failed to load bookings');
  //   }
  // }

  // TODO: Dummy, remove when backend is ready
  void fetchBookings() async {
    List<Booking> bookingList = List.empty(growable: true);

    bookingList.add(
        Booking(
          id: 1,
          dateTime: DateTime.now(),
          seats: 2,
          userName: "Mario Rossi",)
    );

    bookingList.add(
        Booking(
          id: 2,
          dateTime: DateTime.now(),
          seats: 4,
          userName: "Luigi Bianchi",)
    );

    bookingList.add(
        Booking(
          id: 3,
          dateTime: DateTime.now(),
          seats: 6,
          userName: "Giovanni Verdi",)
    );

    bookingList.add(
        Booking(
          id: 4,
          dateTime: DateTime.now(),
          seats: 8,
          userName: "Giuseppe Neri",)
    );

    bookingList.add(
        Booking(
          id: 5,
          dateTime: DateTime.now(),
          seats: 10,
          userName: "Marco Gialli",)
    );

    bookingList.add(
        Booking(
          id: 6,
          dateTime: DateTime.now(),
          seats: 12,
          userName: "Francesco Arancioni",)
    );

    bookingList.add(
        Booking(
          id: 7,
          dateTime: DateTime.now(),
          seats: 14,
          userName: "Alessandro Viola",)
    );

    setState(() {
      bookingsList = bookingList;
      //creates a list of TextEditingControllers, one for each booking to grant the possibility to insert the table number
      for (var i = 0; i < bookingsList.length; i++) {
        _tableControllerList.add(TextEditingController());
      }
    });
  }
}
