import 'package:flutter/material.dart';

class AppBarComandapp extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComandapp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          "Comandapp - zona admin",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
