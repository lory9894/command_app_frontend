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
      required this.paymentType,
      required this.orderType}) {
    total = order.total;
    tableNum = order.tableID!;
    orderState = OrderStateEnum.ACCEPTED;

    // if (userCredential == null) {
    //   user = null;
    // } else {
    //   String userId = await getIdTokenLocal();
    //   user = Userinfo(
    //
    // }
    user = userCredential == null
        ? null // se userCredential è null allora l'utente non è autenticato (?)
        : Userinfo(
            userId:
                idToken!, // TODO: (problema async) assegnare idtoken in un metodo esterno dopo il termine del costruttore
            username: userCredential!.user!.email!);
    order.shoppingCart.forEach((key, value) {
      for (int i = 0; i < value; i++) {
        preparations.add(Preparation.fromDish(key, tableNum));
      }
    });
  }

  // Future<String> getIdTokenLocal() async {
  //   try {
  //     return await userCredential!.user!.getIdToken();
  //   } catch (e) {
  //     print(e);
  //     return "";
  //   }
  //   String token = await FirebaseAuth.instance.currentUser!.getIdToken();
  //   // return token;
  // }

  @override
  toString() {
    return "BackendReservation: $dateTime, $paymentState, $paymentType, $orderState, ${user == null ? null : user!.username}, ${preparations.toString()}";
  }

  toJson() => {
        'dateTime': DateFormat("dd-MM-yyyy HH:mm:ss").format(dateTime),
        'paymentState': paymentState.toString().split(".").last,
        'paymentType': paymentType.toString().split(".").last,
        'orderState': orderState.toString().split(".").last,
        'orderType': orderType.toString().split(".").last,
        'user': user == null
            ? null
            : {
                'userId': user!.userId,
                'username': user!.username,
              },
        'preparationList': preparations
      };
}

class Userinfo {
  String userId, username;
  Userinfo({required this.userId, required this.username});
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

  Map<String, String> toJson() {
    return {
      'name': name,
      'tableNum': tableNum,
      'orderState': orderState.toString().split(".").last
    };
  }
}

class MessageReservation {
  int peopleNum;
  String? tableNum;
  DateTime dateTime;
  late OrderStateEnum state;
  MessageOrder? messageOrder;
  Userinfo? user;

  MessageReservation({required this.peopleNum, required this.dateTime}) {
    if (order.shoppingCart.isNotEmpty) {
      messageOrder = MessageOrder(
          dateTime: dateTime,
          paymentState: PaymentState
              .PAID, //TODO: I preordini sono sempre pagati? (nel caso di ordine al tavolo no)
          paymentType: PaymentTypeEnum.ONLINE,
          orderType: OrderTypeEnum.PREORDER);
    }
    print("userCredential: $userCredential");
    user = userCredential ==
            null //TODO: non so se effettivamente le userCredential sono null o se nel caso di utente non autenticato è userCredential.user null
        ? null
        : Userinfo(userId: idToken!, username: userCredential!.user!.email!);
    state = OrderStateEnum.WAITING;
    tableNum = null;
  }

  Map<String, dynamic> toJson() {
    return {
      'peopleNum': peopleNum,
      'tableNum': tableNum,
      'dateTime': DateFormat("dd-MM-yyyy HH:mm:ss").format(dateTime),
      'state': state.toString().split(".").last,
      'messageOrder': messageOrder == null ? null : messageOrder!.toJson(),
      'user': user == null
          ? null
          : {
              'userId': user!.userId,
              'username': user!.username,
            },
    };
  }
}
