import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:command_app_frontend/global.dart';


class shopping_cart extends StatelessWidget {
  const shopping_cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrello"),
      ),
      body: ListView.builder(
        itemCount: globalShoppingCart.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${globalShoppingCart.values.elementAt(index)}x ${globalShoppingCart.keys.elementAt(index).name}"),
            subtitle: Text("${globalShoppingCart.keys.elementAt(index).price * globalShoppingCart.values.elementAt(index)}€"),
            trailing: IconButton(
                onPressed: () {
                  if (globalShoppingCart.values.elementAt(index) > 1) {
                    globalShoppingCart[globalShoppingCart.keys.elementAt(index)] =
                        globalShoppingCart.values.elementAt(index) - 1;
                  } else {
                    globalShoppingCart.remove(globalShoppingCart.keys.elementAt(index));
                  }
                },
                icon: Icon(Icons.remove)),
          );
        },
      ),
    );
  }
}