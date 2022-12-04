class Booking {
  DateTime reservationDateTime;
  int seats;
  String userName;

  Booking(this.reservationDateTime, this.seats, this.userName);
}


const String sampleJsonBookings = """[
  
]
""";


/// returns list of preparations to show on screen
List<Booking> getBookingsFromJson(String json) {
  throw UnimplementedError();
}

List<Booking> getSampleBookings() {
  return getBookingsFromJson(sampleJsonBookings);
}