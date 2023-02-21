import 'package:flutter/material.dart';

import '../session.dart';



class HomePage extends StatefulWidget {
  final List<SectionContents> sections;

  const HomePage(this.sections, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Benvenuto ${userCredential?.user?.displayName}")),
      ),
      body: Table(
        border: TableBorder.all(),
        children: <TableRow>[
          for (SectionContents section in widget.sections)
            TableRow(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(section.sectionText),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(section.sectionImage),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class SectionContents {
  final String sectionText;
  final String sectionImage;

  const SectionContents(this.sectionText, this.sectionImage);
}