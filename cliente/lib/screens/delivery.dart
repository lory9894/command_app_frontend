import 'package:command_app_frontend/global.dart';
import 'package:command_app_frontend/screens/review_pay.dart';
import "package:flutter/material.dart";

class Delivery extends StatefulWidget {
  const Delivery({Key? key}) : super(key: key);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  bool send_pressed = false;
  TextEditingController _address = TextEditingController();
  TextEditingController _notes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Delivery")),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2, // 20%
            child: Container(),
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _address,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Indirizzo',
                        hintText: "inserisci indirizzo",
                        errorText:
                            send_pressed ? "Inserisci un indirizzo" : null),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 10,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Altre informazioni',
                      )),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (_address.text.isEmpty) {
                          setState(() {
                            send_pressed = true;
                          });
                        } else {
                          takeAway =
                              TakeAway(_address.text, _notes.text, order);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const ReviewPay()),
                          );
                        }
                      },
                      child: Text("Riepilogo ordine")),
                )),
                Expanded(child: Container(), flex: 2),
              ],
            ),
          ),
          Expanded(
            flex: 2, // 20%
            child: Container(),
          ),
        ],
      ),
    );
  }
}
