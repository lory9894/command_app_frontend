import 'dart:convert';

import 'package:command_app_frontend/custom_classes/backend_body.dart';
import 'package:command_app_frontend/screens/pay_card.dart';
import 'package:command_app_frontend/session.dart';
import 'package:command_app_frontend/widgets/app_bar_comandapp.dart';
import 'package:command_app_frontend/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReviewPay extends StatelessWidget {
  const ReviewPay({Key? key}) : super(key: key);

  //TODO: decentrato è una merda, rivedere
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComandapp(
        title: "Riepilogo pagamento",
      ),
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
              ComandAppElevatedButton(
                  text: "Paga con carta",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const PayCard()),
                    );
                  }
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (order.tableID != null && order.tableID!.startsWith("T"))
                ComandAppElevatedButton(
                    text: "Paga alla cassa",
                    onPressed: () {
                      sendOrder(context);
                    }
                ),
              ComandAppElevatedButton(
                  text: "Paga con PayPal",
                  onPressed: () {} //TODO: implement, or maybe not, fuck it, mock it
              ),
            ],
          )
        ],
      ),
    );
  }

  sendOrder(context) async {
    MessageOrder message = MessageOrder(
        dateTime: DateTime.now(),
        paymentState: PaymentState.UNPAID,
        paymentType: PaymentTypeEnum.CASH);
    print("Sending message:\n ${jsonEncode(message)}"); // TODO remove print
    final response = await http.post(Uri.parse("$BASE_URL/order/create"),
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
