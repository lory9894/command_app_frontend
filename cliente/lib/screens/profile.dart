import 'package:command_app_frontend/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../session.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("NOME COGNOME")),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        insetPadding: EdgeInsets.all(30),
                        title:
                            const Center(child: Text('Scansiona il QR Code')),
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
                                          builder: (context) => const Menu()),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
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
          ],
        ),
      ),
    );
  }
}
