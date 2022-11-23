import 'package:command_app_frontend/global.dart';
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
                  Text("Totale: ${order.total}"),
                  ElevatedButton(
                    onPressed: () {
                      if (order.tableID == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              insetPadding: EdgeInsets.all(30),
                              title: Text(
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
                                        }
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      order.tableID = "Reservation";
                                    },
                                    child: Text('Prenota Tavolo'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      order.tableID = "TakeAway";
                                    },
                                    child: Text('Asporto'),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      //TODO: schermata di pagamento
                    },
                    child: const Text("Completa ordine"),
                  ),
                ],
              )),
        ]));
  }

  shoppingCartList() {
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
                  if (order.shoppingCart.values.elementAt(index) > 1) {
                    order.shoppingCart[
                            order.shoppingCart.keys.elementAt(index)] =
                        order.shoppingCart.values.elementAt(index) - 1;
                  } else {
                    order.shoppingCart
                        .remove(order.shoppingCart.keys.elementAt(index));
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.remove)),
            IconButton(
                onPressed: () {
                  if (!order.shoppingCart
                      .containsKey(order.shoppingCart.keys.elementAt(index))) {
                    order.shoppingCart[
                        order.shoppingCart.keys.elementAt(index)] = 1;
                  } else {
                    order.shoppingCart[order.shoppingCart.keys
                        .elementAt(index)] = order.shoppingCart[
                            order.shoppingCart.keys.elementAt(index)]! +
                        1;
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.add)),
          ]),
        );
      },
    );
  }
}
