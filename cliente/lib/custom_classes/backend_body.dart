import 'dart:convert';

import 'package:intl/intl.dart';

import '../session.dart';
import 'dish.dart';

enum PaymentState { PAID, UNPAID }

enum PaymentTypeEnum { CASH, ONLINE }

enum OrderTypeEnum { TAKEAWAY, DELIVERY, IN_RESTAURANT, PREORDER }

enum OrderStateEnum { WAITING, ACCEPTED, REJECTED, SENT_TO_KITCHEN }

class MessageOrder {
  late double total;
  late String tableNum;
  late DateTime dateTime;
  late PaymentState paymentState;
  late PaymentTypeEnum paymentType;
  late OrderTypeEnum orderType;
  late OrderStateEnum orderState;
  Userinfo? user;
  List<Preparation> preparations = List.empty(growable: true);

  MessageOrder(
      {required this.dateTime,
      required this.paymentState,
      required this.paymentType}) {
    total = order.total;
    tableNum = order.tableID!;
    orderState = OrderStateEnum
        .ACCEPTED; //TODO: decidere se vogliamo accettare o meno gli ordini di default

    user = userCredential ==
            null //TODO: non so se effettivamente le userCredential sono null o se nel caso di utente non autenticato è userCredential.user null
        ? null
        : Userinfo(
            userid: userCredential!.user!.uid,
            username: userCredential!.user!.email!);
    order.shoppingCart.forEach((key, value) {
      for (int i = 0; i < value; i++) {
        preparations.add(Preparation.fromDish(key, tableNum));
      }
    });
  }

  @override
  toString() {
    return "BackendReservation: $dateTime, $paymentState, $paymentType, $orderState, ${user == null ? null : user!.username}, ${preparations.toString()}";
  }

  toJson() => {
        'dateTime': DateFormat("dd-MM-yyyy HH:mm:ss").format(dateTime),
        'paymentState': paymentState.toString().split(".").last,
        'paymentType': paymentType.toString().split(".").last,
        'orderState': orderState.toString().split(".").last,
        'user': user == null
            ? null
            : {
                'userid': user!.userid,
                'username': user!.username,
              },
        'preparations': jsonEncode(preparations)
      };
}

class Userinfo {
  String userid, username;
  Userinfo({required this.userid, required this.username});
}

class Preparation {
  String name, tableNum;
  late OrderStateEnum orderState;

  Preparation({required this.name, required this.tableNum}) {
    orderState = OrderStateEnum.WAITING;
  }

  factory Preparation.fromDish(Dish dish, String tableNum) {
    return Preparation(name: dish.name, tableNum: tableNum);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tableNum': tableNum,
      'orderState': orderState.toString().split(".").last
    };
  }

  Preparation.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        tableNum = json['tableNum'],
        orderState = json['orderState'];
}

class MessageReservation {
  int peopleNum;
  String? tableNum;
  DateTime dateTime;
  late OrderStateEnum state;
  MessageOrder? messageOrder;

  MessageReservation(
      {required this.peopleNum, required this.dateTime, this.messageOrder}) {
    state = OrderStateEnum.WAITING;
    tableNum = null;
  }
}
