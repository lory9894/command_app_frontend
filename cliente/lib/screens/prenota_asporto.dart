import 'package:command_app_frontend/screens/shopping_cart.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class PrenotaAsporto extends StatefulWidget {
  const PrenotaAsporto({Key? key}) : super(key: key);

  @override
  _PrenotaAsportoState createState() => _PrenotaAsportoState();
}


class _PrenotaAsportoState extends State<PrenotaAsporto> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeinput = TextEditingController();


  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    timeinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center (child: Text("RITIRO D'ASPORTO")),
        ),
        body:Padding(
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
                          child: TextField(
                            controller: dateInput,
                            //editing controller of this TextField
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today), //icon of text field
                                labelText: "Inserisci data" //label text of field
                            ),
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  dateInput.text = formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Time is not selected");
                              }
                            },
                          ),
                        ),
                        const Spacer(flex: 2),
                      ],
                    ),
                    Row(
                      children: [
                        const Spacer(flex: 2),
                        Expanded(
                          flex: 6,
                          child: TextField(
                            controller: timeinput,
                            //editing controller of this TextField
                            decoration: InputDecoration(
                                icon: Icon(Icons.access_time), //icon of text field
                                labelText: "Inserisci ora" //label text of field
                            ),
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());

                              if (pickedTime != null) {
                                print(pickedTime.format(context)); //pickedDate output format => 2021-03-10 00:00:00.000String formattedTime =
                                DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                //converting to DateTime so that we can further format on different pattern.
                                print(parsedTime); //output 1970-01-01 22:53:00.000
                                String formattedTime =
                                DateFormat('HH:mm').format(parsedTime);
                                print(formattedTime); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  timeinput.text =
                                      formattedTime; //set output date to TextField value.
                                });
                              } else {}
                            },
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
                  child: const Text("Riepilogo Ordine"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShoppingCart()),
                    );
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),

    );
  }
}