import 'package:flutter/material.dart';

class ButtonData {
  ///text to show to user
  final String buttonText;
  /// widget to push on stack when button clicked
  final Widget buttonLink;

  const ButtonData(this.buttonText, this.buttonLink);
}

class MultipleButtonsPage extends StatefulWidget{
  const MultipleButtonsPage(this.buttonsData, {super.key});

  final List<ButtonData> buttonsData;

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
    for (ButtonData buttonData in widget.buttonsData) {
      Widget buttonWidget = SizedBox(
        width: 300,
        height: 150,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => buttonData.buttonLink,
              ),
            );
          },
          child: Text(
            buttonData.buttonText,
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