import 'package:command_app_frontend/screens/book_table.dart';
import 'package:command_app_frontend/screens/menu.dart';
import 'package:flutter/foundation.dart';
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
        title: Center(
            child: Text("Benvenuto ${userCredential?.user?.displayName}")),
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
              if (!kIsWeb)
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
                      order.tableID = "P1";
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const BookTable()),
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
