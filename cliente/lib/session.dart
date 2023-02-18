import 'package:command_app_frontend/custom_classes/reservation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'custom_classes/order.dart';
import 'custom_classes/take_away.dart';

/// Keeps track of the current session items (order, takeaway, userId).

Order order = Order();
TakeAway? takeAway;
UserCredential? userCredential;
Reservation? reservation;
String? idToken;

//const String BASE_URL = (kIsWeb) ? "http://api-gateway:8080" : "http://lorenzodentis.ddns.net:8080"; //TODO this on docker
const String BASE_URL =
    "http://lorenzodentis.ddns.net:8080"; //TODO this on android development
