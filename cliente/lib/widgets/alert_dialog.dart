import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).popUntil((route) => route.isFirst);
    },
  ); // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Richiesta inviata"),
    content: Text("La sua richiesta è stata inviata con successo."),
    actions: [
      okButton,
    ],
  ); // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
