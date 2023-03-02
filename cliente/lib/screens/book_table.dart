import 'dart:convert' as book_table;

import 'package:command_app_frontend/screens/menu.dart';
import 'package:command_app_frontend/session.dart';
import 'package:command_app_frontend/widgets/app_bar_comandapp.dart';
import 'package:command_app_frontend/widgets/text_fields.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../custom_classes/backend_body.dart';
import '../custom_classes/reservation.dart';

class BookTable extends StatefulWidget {
  const BookTable({Key? key}) : super(key: key);

  @override
  State<BookTable> createState() => _BookTableState();
}

class _BookTableState extends State<BookTable> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  TextEditingController numPeopleInput = TextEditingController();
  final SizedBox _sizedBox = const SizedBox(height: 40);

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    timeInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComandapp(title: "Prenota tavolo"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Spacer(),
            Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Spacer(flex: 2),
                      Expanded(
                        flex: 6,
                        child: ComandAppTextField(
                          controller: dateInput,
                          iconData: Icons.calendar_today,
                          labelText: "Inserisci data",
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 7))
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                setState(() {
                                  dateInput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                            }
                          },
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                  _sizedBox,
                  Row(
                    children: [
                      const Spacer(flex: 2),
                      Expanded(
                        flex: 6,
                        child: ComandAppTextField(
                          controller: timeInput,
                          iconData: Icons.access_time,
                          labelText: "Inserisci ora",
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

                            if (pickedTime != null) {
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(pickedTime.format(context).toString());
                              //converting to DateTime so that we can further format on different pattern.
                              String formattedTime =
                                  DateFormat('HH:mm').format(parsedTime);
                              setState(() {
                                timeInput.text =
                                    formattedTime; //set output date to TextField value.
                              });
                            } else {}
                          },
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                  _sizedBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Spacer(flex: 2),
                        Expanded(
                          flex: 6,
                          child: Text(
                            'Numero persone',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Spacer(flex: 2),
                      ]),
                  Row(
                    children: [
                      const Spacer(flex: 2),
                      Expanded(
                        flex: 6,
                        child: NumberInputPrefabbed.roundedEdgeButtons(
                          controller: numPeopleInput,
                          min: 1,
                          max: 20,
                          incDecBgColor: Colors.blue,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 50),
                  textStyle: const TextStyle(fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text("Prenota"),
                onPressed: () {
                  _sendReservation(false);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 50),
                  textStyle: const TextStyle(fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text("Scegli il menù"),
                onPressed: () {
                  _sendReservation(true);
                },
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _sendReservation(bool goToMenu) async {
    if (validate()) {
      reservation = Reservation(
          dateInput.text, timeInput.text, int.parse(numPeopleInput.text));
      print(reservation);
      if (goToMenu) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Menu()),
        );
      } else {
        MessageReservation message = MessageReservation(
            dateTime: DateTime.now(), peopleNum: reservation!.peopleNum);
        print(book_table.jsonEncode(message));
        final response =
            await http.post(Uri.parse("$BASE_URL/reservation/create"),
                headers: <String, String>{
                  'Content-Type': 'application/json',
                },
                body: book_table.jsonEncode(message));
        if (response.statusCode == 200) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else {
          print(response.body);
          throw Exception('Failed to change state');
        }
      }
    }
  }

  bool validate() {
    if (dateInput.text == "" ||
        timeInput.text == "" ||
        numPeopleInput.text == "0") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Errore"),
              content: const Text("Compila tutti i campi"),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      return false;
    } else {
      return true;
    }
  }
}
