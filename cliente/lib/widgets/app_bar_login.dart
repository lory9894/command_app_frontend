import 'package:command_app_frontend/screens/login.dart';
import 'package:flutter/material.dart';

import '../screens/shopping_cart.dart';
import '../session.dart';

class AppBarLogin extends StatefulWidget implements PreferredSizeWidget {
  const AppBarLogin({super.key});

  @override
  State<AppBarLogin> createState() => _AppBarLoginState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarLoginState extends State<AppBarLogin> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: order.tableID == null
            ? const Text('Menu')
            : order.tableID!.startsWith('T')
                ? Text(
                    'Tavolo ${order.tableID!.substring(1, order.tableID!.length)}')
                : const Text(''),
      ),
      // title: order.tableID != null && order.tableID!.startsWith("T")
      //     ? Center(
      //         child: Text(
      //             "Tavolo ${order.tableID!.substring(1, order.tableID!.length)}"))
      //     : order.tableID!.startsWith("A")
      //         ? Text(
      //             "Asporto ${order.tableID!.substring(1, order.tableID!.length)}")
      //         : const Center(child: Text("Menu")),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ShoppingCart()));
              },
              icon: const Icon(Icons.shopping_cart)),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 8, right: 20),
            child: userId != null
                ? IconButton(
                    onPressed: () {
                      userId = null;
                      order.tableID = null;
                      //TODO: insert firebase logout
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                    },
                    icon: const Icon(Icons.logout))
                : null)
      ],
    );
  }
}
