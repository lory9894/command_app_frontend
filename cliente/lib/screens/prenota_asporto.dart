import 'package:command_app_frontend/screens/cart.dart';
import 'package:command_app_frontend/widgets/app_bar_comandapp.dart';
import 'package:command_app_frontend/widgets/buttons.dart';
import 'package:command_app_frontend/widgets/text_fields.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TakeAway extends StatefulWidget {
  const TakeAway({Key? key}) : super(key: key);

  @override
  State<TakeAway> createState() => _TakeAwayState();
}


class _TakeAwayState extends State<TakeAway> {
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
        appBar: const AppBarComandapp(
          title: "  Asporto",
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
                          child: ComandAppTextField(
                            controller: dateInput,
                            labelText: "Inserisci data",
                            iconData: Icons.calendar_today,
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
                                print(formattedDate); //formatted date output using intl package =>  2016-01-25
                                setState(() {
                                  dateInput.text = formattedDate; //set output date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
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
                          child: ComandAppTextField(
                            controller: timeinput,
                            labelText: "Inserisci ora",
                            iconData: Icons.access_time,
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
                child: ComandAppElevatedButton(
                  text: "Riepilogo Ordine",
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