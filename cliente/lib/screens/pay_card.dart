import 'dart:convert';

import 'package:command_app_frontend/payment_utils/card_month_input_formatter.dart';
import 'package:command_app_frontend/session.dart';
import 'package:command_app_frontend/widgets/app_bar_comandapp.dart';
import 'package:command_app_frontend/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../custom_classes/backend_body.dart';
import '../payment_utils/card_number_input_formatter.dart';
import '../payment_utils/card_type_enum.dart';
import '../payment_utils/card_utils.dart';

class PayCard extends StatefulWidget {
  const PayCard({Key? key}) : super(key: key);

  @override
  State<PayCard> createState() => _PayCardState();
}

class _PayCardState extends State<PayCard> {
  TextEditingController cardNumberController = TextEditingController();

  CardType cardType = CardType.Invalid;

  @override
  void initState() {
    cardNumberController.addListener(
      () {
        getCardTypeFrmNumber();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    super.dispose();
  }

  void getCardTypeFrmNumber() {
    if (cardNumberController.text.length <= 6) {
      String input = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(input);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComandapp(
        title: "Pagamento",
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Spacer(),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19),
                        CardNumberInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        hintText: "Numero carta",
                        suffix: CardUtils.getCardIcon(cardType),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Nome e cognome"),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              // Limit the input
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: const InputDecoration(hintText: "CVV"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              CardMonthInputFormatter(),
                            ],
                            decoration:
                                const InputDecoration(hintText: "MM/AA"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ComandAppElevatedButton(
                  text: "Paga",
                  onPressed: () {
                    if (order.tableID!.startsWith("P") ||
                        order.tableID!.startsWith("O")) {
                      //prenotation
                      sendPrenotation(); //TODO: capire cosa cazzo fare in caso di preorder, vedere il todo in sendPrenotation
                    } else {
                      //preorder, takeaway, delivery or in restaurant
                      sendOrder();
                    }
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  sendOrder() async {
    OrderTypeEnum orderType;
    switch (order.tableID!.substring(0, 1)) {
      case "A":
        orderType = OrderTypeEnum.TAKEAWAY;
        break;
      case "D":
        orderType = OrderTypeEnum.DELIVERY;
        break;
      case "T":
        orderType = OrderTypeEnum.IN_RESTAURANT;
        break;
      default:
        orderType = OrderTypeEnum.IN_RESTAURANT;
    }
    MessageOrder message = MessageOrder(
        dateTime: DateTime.now(),
        paymentState: PaymentState.PAID,
        paymentType: PaymentTypeEnum.ONLINE,
        orderType: orderType);
    print(message);
    final response = await http.post(Uri.parse("$BASE_URL/order/create"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(message));
    if (response.statusCode == 200) {
      order.shoppingCart.clear();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      print(response.body);
      throw Exception('Failed to change state');
    }
  }

  sendPrenotation() async {
    MessageReservation message = MessageReservation(
        dateTime: DateTime.now(), peopleNum: reservation!.peopleNum);
    print(jsonEncode(message));
    // nel caso sia una reservation va inviato a /reservation/create altrimenti a /reservation/create/preorder
    String url = order.tableID!.startsWith("P")
        ? "$BASE_URL/reservation/create"
        : "$BASE_URL/reservation/create/preorder";
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(message));
    if (response.statusCode == 200) {
      order.shoppingCart.clear();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      print(response.body);
      throw Exception('Failed to change state');
    }
  }
}
