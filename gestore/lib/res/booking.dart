import 'dart:convert';
import 'package:intl/intl.dart';

class Booking {
  DateTime dateTime;
  int seats;
  String userName;

  Booking(this.dateTime, this.seats, this.userName);

  String getStringDate(){
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
}


const String sampleJsonBookings = """
[
  {
    "timestamp": 1666110600,
    "seats": 8,
    "userName": "pinocchio12"
  },
  {
    "timestamp": 1666196400,
    "seats": 2,
    "userName": "dark_liliana69"
  },
  {
    "timestamp": 1666203600,
    "seats": 6,
    "userName": "lil_rossano666"
  },
  {
    "timestamp": 1666207200,
    "seats": 3,
    "userName": "coppo_zacchi<3"
  }
]
""";


/// returns list of preparations to show on screen
List<Booking> getBookingsFromJson(String json) {
  List<Booking> bookingsList = List.empty(growable: true);
  List map = jsonDecode(json);
  for (var bookingMap in map) {
    // convert timestamp to date time in seconds
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(bookingMap['timestamp'] * 1000);
    Booking booking = Booking(
        dateTime,
        bookingMap['seats'],
        bookingMap['userName']
    );
    bookingsList.add(booking);
  }
  return bookingsList;
}

List<Booking> getSampleBookings() {
  return getBookingsFromJson(sampleJsonBookings);
}