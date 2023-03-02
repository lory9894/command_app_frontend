// ComandApp text field
import 'package:flutter/material.dart';

class ComandAppTextField extends StatelessWidget {
  // fields
  final TextEditingController controller;
  final String? labelText;
  final void Function() onTap;
  final IconData? iconData;

  const ComandAppTextField({Key? key, required this.controller, this.labelText, this.iconData, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      //editing controller of this TextField
      decoration: InputDecoration(
        // Icon(Icons.calendar_today, color: Theme.of(context).primaryColor)
        icon: Icon(iconData, color: Theme.of(context).primaryColor,), //icon of text field
        labelText: labelText, //label text of field
        floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      readOnly: true,
      //set it true, so that user will not able to edit text
      onTap: onTap,
    );
  }

}