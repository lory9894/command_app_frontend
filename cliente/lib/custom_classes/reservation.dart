import 'package:intl/intl.dart';

class Reservation {
  late DateTime _dateTime;
  int _peopleNum;

  DateTime get dateTime => _dateTime;

  Reservation(date, time, this._peopleNum) {
    if (time == null || time.isEmpty) time = "19:45";
    _dateTime =
        DateFormat("dd-MM-yyyy HH:mm:ss").parse(date + " " + time + ":00");
  }

  @override
  toString() {
    return "Reservation: $_dateTime, $_peopleNum";
  }

  toJson() => {
        'dateTime': DateFormat("dd-MM-yyyy HH:mm:ss").format(_dateTime),
        'peopleNum': _peopleNum,
      };

  int get peopleNum => _peopleNum;
}

//TODO: questa classe può essere fusa con la classe MessageReservation
