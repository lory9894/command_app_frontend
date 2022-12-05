import 'package:command_app_frontend/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../global.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("NOME COGNOME")),
      ),
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
                child: Container(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            insetPadding: EdgeInsets.all(30),
                            title: const Center(
                                child: Text('Scansiona il QR Code')),
                            children: [
                              SizedBox(
                                height: 300,
                                width: 200,
                                child: MobileScanner(
                                    allowDuplicates: false,
                                    onDetect: (barcode, args) {
                                      if (barcode.rawValue != null) {
                                        final String code = barcode.rawValue!;
                                        debugPrint('Barcode found! $code');
                                        order.tableID = code;
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Menu()),
                                        );
                                      }
                                    }),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text("Ordina al tavolo"),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      //TODO: chiedi al backend l'id di consegna
                      order.tableID = "D1";
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Menu()),
                      );
                    },
                    child: const Text("Ordina a casa"),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      //TODO: chiedi al backend l'id da asporto
                      order.tableID = "A1";
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Menu()),
                      );
                    },
                    child: const Text("Ordina da asporto"),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      /* TODO: schermata di pre ordine
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Menu()),
                      );
                       */
                    },
                    child: const Text("Pre-ordina"),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      /* TODO: schermata di prenotazione
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Menu()),
                    );
                     */
                    },
                    child: const Text("Prenota"),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2, // 20%
          child: Container(),
        ),
      ]),
    );
  }
}
