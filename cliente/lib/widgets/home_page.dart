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
      // if client is on desktop, show the sections in a 2x2 grid. Otherwise, show them in a 1x4 grid

      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(children: [
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
            ]);
          } else {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: widget.sections[0],
                  ),
                  Expanded(
                    flex: 1,
                    child: widget.sections[1],
                  ),
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
            );
          }
        },
      ),



      // body: Row(children: [
      //   Expanded(
      //     flex: 2, // 20%
      //     child: Container(),
      //   ),
      //   Expanded(
      //     flex: 6,
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Expanded(
      //           flex: 1,
      //           child: Row(
      //             children: [
      //               Expanded(
      //                 flex: 1,
      //                 child: widget.sections[0],
      //               ),
      //               Expanded(
      //                 flex: 1,
      //                 child: widget.sections[1],
      //               ),
      //             ],
      //           ),
      //         ),
      //         Expanded(
      //           flex: 1,
      //           child: Row(
      //             children: [
      //               Expanded(
      //                 flex: 1,
      //                 child: widget.sections[2],
      //               ),
      //               Expanded(
      //                 flex: 1,
      //                 child: widget.sections[3],
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      //   Expanded(
      //     flex: 2, // 20%
      //     child: Container(),
      //   ),
      // ]),
    );
  }
}

class HomeSection extends StatelessWidget {
  final String sectionTitle;
  final String sectionImageName;
  final VoidCallback onClicked;

  const HomeSection(this.sectionTitle, this.sectionImageName, this.onClicked, {super.key});


  @override
  Widget build(BuildContext context) {
    // section is made of an orange button with an image and the name of the section it brings to.
    // When the button is clicked, it calls the function onClicked and brings the user to the section
    // sectionTitle is green, rounded corners, shadow.
    // Image vertically centered, title vertically centered

    return Container(
        width: 200,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: TextButton(
          onPressed: onClicked,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/sections/$sectionImageName.png",
                height: 70,
              ),
              Text(
                sectionTitle,
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
      );

  }

}