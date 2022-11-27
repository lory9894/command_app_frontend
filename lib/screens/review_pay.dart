import 'dart:convert';

import 'package:command_app_frontend/global.dart';
import 'package:command_app_frontend/screens/pay_card.dart';
import 'package:command_app_frontend/screens/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReviewPay extends StatelessWidget {
  const ReviewPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total2 = ModalRoute.of(context)!.settings.arguments as double;
    final total = total2.toString();
    return Scaffold(
      appBar: AppBar(
          title: Text("Pagamento")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Totale: $total €"),
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PayCard()),
                );
              },
              child: const Text('PayPal'),
            ),
          ],
        ),
      ],),
      );
  }
}


