import 'package:flutter/material.dart';

class AppBarComandapp extends StatelessWidget implements PreferredSizeWidget {
  // fields
  final String title;
  final List<Widget>? actions;

  const AppBarComandapp({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      // add actions if they exist, otherwise don't
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
