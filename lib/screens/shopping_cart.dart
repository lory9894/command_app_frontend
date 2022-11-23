import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:command_app_frontend/global.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  //TODO: DEBUG RIMUOVERE
  @override
  void initState() {
    globalShoppingCart[Dish(name: "il Petrone", description: "vabbeh", price: 5.50, course: "panino", imageUrl: "http://www.di.unito.it/~giovanna/gioNew1.jpg")] = 2;
    globalShoppingCart[Dish(name: "Coppo Divino", description: "vino", price: 7, course: "bevanda")] = 1;
    print(globalShoppingCart);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrello"),
      ),
      body: Column(
       children: [
         Padding(padding: EdgeInsets.symmetric(vertical: 10)),
         Container(
             height: 500,
           width: 500,
           child: shoppingCartList()
         ),
         Container(
             height:100,
             width: 300,
             child: const TextField(
               decoration: InputDecoration(
                 border: OutlineInputBorder(),
                 labelText: 'Codice Promozionale',
               ),
             )
         ),
         Container(
           height:100,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Text("Totale: FAKEPRICE"),
               ElevatedButton(
                 onPressed: () {}, child: Text("Paga"),),
              ],
         )
         ),
       ]
      )
    );
  }

  shoppingCartList() {
    return ListView.builder(
      itemCount: globalShoppingCart.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: globalShoppingCart.keys.elementAt(index).imageUrl != null
                ? NetworkImage(globalShoppingCart.keys.elementAt(index).imageUrl!)
                : null,
            child: globalShoppingCart.keys.elementAt(index).imageUrl == null ? Text(globalShoppingCart.keys.elementAt(index).name[0]) : null,
          ),
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
                setState(() {});
              },
              icon: Icon(Icons.remove)),
        );
      },
    );
  }
}