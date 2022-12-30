import 'package:command_app_frontend/screens/menu.dart';
import 'package:command_app_frontend/screens/prenota_tavolo.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../session.dart';

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
                      minimumSize: const Size.fromHeight(20),
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
                    child: const FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        "Ordina al tavolo",
                        style: TextStyle(fontSize: 60),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
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
                    child: const FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        "Ordina a casa",
                        style: TextStyle(fontSize: 60),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      //TODO: chiedi al backend l'id da asporto. Oltretutto bisogna tenere traccia del fatto che è un asporto, quindi il menù deve andare
                      //alla pagina PrenotaAsporto dopo aver scelto i piatti
                      order.tableID = "A1";
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Menu()),
                      );
                    },
                    child: const FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        "Ordina asporto",
                        style: TextStyle(fontSize: 60),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      //TODO: chiedi al backend l'id di prenotazione
                      order.tableID = "P1";
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const PrenotaTavolo()),
                      );
                    },
                    child: const FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        "Prenota",
                        style: TextStyle(fontSize: 60),
                      ),
                    ),
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
