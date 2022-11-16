import 'package:flutter/material.dart';

class Menu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: [
    ExpansionTile(
    title: Text(
    'Primi',
    ),
    children: <Widget>[
    ListTile(
    title: Text(
    'coppo',
    style: TextStyle(fontWeight: FontWeight.w700),
    ),
    ),
      ListTile(
        title: Text(
          'petrone',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    ],
    ),
        Text("primo"),
        Text("primo"),
      ],
    );
  }

}