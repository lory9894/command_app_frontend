import 'package:flutter/material.dart';

import '../session.dart';



class HomePage extends StatefulWidget {
  final List<HomeSection> sections;

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
      // body is two rows containing a HomeSection each
      body: Row(children: [
        Expanded(
          flex: 2, // 20%
          child: Container(),
        ),
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: widget.sections[0],
                    ),
                    Expanded(
                      flex: 1,
                      child: widget.sections[1],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: widget.sections[2],
                    ),
                    Expanded(
                      flex: 1,
                      child: widget.sections[3],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2, // 20%
          child: Container(),
        ),
      ]),


      // body: ListView.builder(
      //   itemCount: widget.sections.length,
      //   itemBuilder: (context, index) {
      //     final section = widget.sections[index];
      //     return section.build(context);
      //   },
      // ),
    );
  }
}

class HomeSection extends StatelessWidget {
  final String sectionTitle;
  final String sectionDescription;
  final String sectionImageName;
  final VoidCallback onClicked;

  const HomeSection(this.sectionTitle, this.sectionDescription, this.sectionImageName, this.onClicked, {super.key});


  @override
  Widget build(BuildContext context) {
    // section is a box containing an image, the name of the section it brings to and a description of the section
    // When the container clicked, it calls the function onClicked and brings the user to the section
    // #ffb238 background, black text, rounded corners, shadow. Takes the whole width
    // leave some space between the sections. Image vertically centered.

    return InkWell(
      onTap: onClicked,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Image.asset("assets/images/sections/$sectionImageName.png"),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  sectionTitle,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                sectionDescription,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );

    // return ListTile(
    //   leading: Image.asset("assets/images/sections/$sectionImageName.png"),
    //   title: Text(sectionText),
    //   onTap: onClicked,
    // );
  }

}