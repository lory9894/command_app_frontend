import 'package:command_app_frontend/global.dart';
import 'package:flutter/material.dart';

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
          title: Text("Carrello"),
        ),
        body: Column(children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Container(height: 500, width: 500, child: shoppingCartList()),
          Container(
              height: 100,
              width: 300,
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Codice Promozionale',
                ),
              )),
          Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Totale: FAKEPRICE"),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Completa ordine"),
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
