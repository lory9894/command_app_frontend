import 'package:flutter/material.dart';

import '../auth/auth_methods.dart';
import '../screens/home_page.dart';
import '../screens/login.dart';
import '../screens/shopping_cart.dart';
import '../session.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.login),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      },
    );
  }
}

class ButtonShoppingCart extends StatelessWidget {
  const ButtonShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.shopping_cart),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ShoppingCart(),
          ),
        );
      },
    );
  }
}

class ButtonLogout extends StatelessWidget {
  const ButtonLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 8, right: 20),
        child: userCredential != null
            ? IconButton(
            onPressed: () {
              signOutFromGoogle();
              order.tableID = null;
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const HomePage()));
            },
            icon: const Icon(Icons.logout))
            : const ButtonLogin()
    );
  }
}
