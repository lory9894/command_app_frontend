import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AdminHomePage(),
    );
  }
}

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleButtonsPage([
      "Area prenotazioni",
      "Area cucina",
      "Area servizio",
      "Area pinocchio"
    ]);
  }
}

class MultipleButtonsPage extends StatefulWidget{
  const MultipleButtonsPage(this.buttonsTextList, {super.key});

  final List<String> buttonsTextList;

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
