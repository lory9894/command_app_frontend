import 'package:flutter/material.dart';

class MultipleButtonsPage extends StatefulWidget{
  const MultipleButtonsPage(this.buttonsTextList, {super.key});
  //TODO instead of buttons text and buttons link use 1 list where each element is an array of the buttons properties

  final List<String> buttonsTextList;
  // final List<Widget> buttonsLinks;

  @override
  _MultipleButtonsPageState createState() => _MultipleButtonsPageState();

}


class _MultipleButtonsPageState extends State<MultipleButtonsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comandapp - zona admin"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: getButtonsWidgets()
        ),
      ),
    );
  }

  List<Widget> getButtonsWidgets(){
    List<Widget> buttonsWidgets = List.empty(growable: true);
    for (String buttonText in widget.buttonsTextList) {
      Widget buttonWidget = SizedBox(
        width: 300,
        height: 150,
        child: ElevatedButton(
          onPressed: null,
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 30),
          ),
        ),
      );
      buttonsWidgets.add(buttonWidget);
      buttonsWidgets.add(const SizedBox(height: 10));
    }
    return buttonsWidgets;
  }
}