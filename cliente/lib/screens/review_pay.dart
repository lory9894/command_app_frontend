import 'dart:convert';

import 'package:command_app_frontend/custom_classes/backend_body.dart';
import 'package:command_app_frontend/screens/pay_card.dart';
import 'package:command_app_frontend/session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReviewPay extends StatelessWidget {
  const ReviewPay({Key? key}) : super(key: key);

  //TODO: decentrato è una merda, rivedere
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pagamento")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Totale: ${order.total} €"),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PayCard()),
                  );
                },
                child: const Text('Paga con carta'),
              ),
              if (order.tableID != null && order.tableID!.startsWith("T"))
                ElevatedButton(
                    onPressed: () {
                      sendOrder(context);
                    },
                    child: const Text('Paga alla cassa')),
              ElevatedButton(
                onPressed:
                    () {}, //TODO: implement, or maybe not, fuck it, mock it
                child: const Text('PayPal'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  sendOrder(context) async {
    MessageOrder message = MessageOrder(
        dateTime: DateTime.now(),
        paymentState: PaymentState.UNPAID,
        paymentType: PaymentTypeEnum.CASH,
        orderType: OrderTypeEnum.IN_RESTAURANT);
    print("Sending message:\n ${jsonEncode(message)}"); // TODO remove print
    print("$BASE_URL/order/create");
    final response = await http.post(
        Uri.parse(
            "$BASE_URL/order/create"), //TODO: chiedere a gianluca come si fa a creare un ordine al tavolo se il preordine presuppone un utente. lui mi aveva detto che l'utente poteva essere null
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(message));
    if (response.statusCode == 200) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      print(response.body);
      throw Exception('Failed to change state');
    }
  }
}
