import 'package:command_app_frontend/global.dart';
import 'package:command_app_frontend/screens/pay_card.dart';
import 'package:flutter/material.dart';

class ReviewPay extends StatelessWidget {
  const ReviewPay({Key? key}) : super(key: key);

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
}
