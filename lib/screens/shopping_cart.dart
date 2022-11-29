import 'package:command_app_frontend/global.dart';
import 'package:command_app_frontend/screens/review_pay.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Carrello"),
        ),
        body: Column(children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Expanded(
              child:
                  SizedBox(height: 400, width: 500, child: shoppingCartList())),
          const SizedBox(
              height: 100,
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Codice Promozionale',
                ),
              )),
          SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Totale: ${order.total} €"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ReviewPay()),
                      );
                    },
                    child: const Text("Completa ordine"),
                  ),
                ],
              )),
        ]));
  }

  Widget finalizationDialog(BuildContext context) {
    return SimpleDialog(
      insetPadding: EdgeInsets.all(30),
      title: const Text(
          'Scansiona il QR Code o scegli altre modalità di consumazione'),
      children: [
        SizedBox(
          height: 300,
          width: 200,
          child: MobileScanner(
              allowDuplicates: false,
              onDetect: (barcode, args) {
                if (barcode.rawValue != null) {
                  final String code = barcode.rawValue!;
                  debugPrint('Barcode found: $code');
                  order.tableID = code;
                  Navigator.of(context).pop(context);
                }
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              order.tableID = "Preordine";
              Navigator.of(context).pop(context);
            },
            child: const Text('Preordina'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              order.tableID = "TakeAway";
              Navigator.of(context).pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ReviewPay()),
              );
            },
            child: const Text('Asporto'),
          ),
        ),
      ],
    );
  }

  Widget shoppingCartList() {
    return ListView.builder(
      itemCount: order.shoppingCart.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage:
                order.shoppingCart.keys.elementAt(index).imageUrl != null
                    ? NetworkImage(
                        order.shoppingCart.keys.elementAt(index).imageUrl!)
                    : null,
            child: order.shoppingCart.keys.elementAt(index).imageUrl == null
                ? Text(order.shoppingCart.keys.elementAt(index).name[0])
                : null,
          ),
          title: Text(
              "${order.shoppingCart.values.elementAt(index)}x ${order.shoppingCart.keys.elementAt(index).name}"),
          subtitle: Text(
              "${order.shoppingCart.keys.elementAt(index).price * order.shoppingCart.values.elementAt(index)}€"),
          trailing: Wrap(spacing: 12, children: [
            IconButton(
                onPressed: () {
                  order.removeDish(order.shoppingCart.keys.elementAt(index));
                  setState(() {});
                },
                icon: const Icon(Icons.remove)),
            IconButton(
                onPressed: () {
                  order.addDish(order.shoppingCart.keys.elementAt(index));
                  setState(() {});
                },
                icon: const Icon(Icons.add)),
          ]),
        );
      },
    );
  }
}
