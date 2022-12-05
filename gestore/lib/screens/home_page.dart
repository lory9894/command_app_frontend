import 'package:command_app_frontend/screens/bookings_table.dart';
import 'package:command_app_frontend/screens/kitchen_table.dart';
import 'package:flutter/material.dart';

import '../widgets/multiple_buttons_page.dart';
import 'waiter_table.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});
  static const List<ButtonData> adminPages = [
    ButtonData("Area servizio", ServiceTable()),
    ButtonData("Area cucina", KitchenTable()),
    ButtonData("Area prenotazioni", BookingsTable()),
  ];

  @override
  Widget build(BuildContext context) {
    return const MultipleButtonsPage(adminPages);
  }
}