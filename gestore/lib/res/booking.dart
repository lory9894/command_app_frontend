import 'package:intl/intl.dart';

class Booking {
  final int id;
  final DateTime dateTime;
  final int seats;
  final String userName;

  static final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');

  Booking(
      {required this.id,
      required this.dateTime,
      required this.seats,
      required this.userName});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      dateTime: formatter.parse(json['dateTime']),
      seats: json['peopleNum'],
      userName: json['reservationName'],
    );
  }

  toString() =>
      "Booking(dateTime: $dateTime, seats: $seats, userName: $userName)";

  String getStringDate() {
    return dateTime.toString().substring(0, 16);
  }
}
