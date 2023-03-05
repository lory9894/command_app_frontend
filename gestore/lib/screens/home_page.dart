import 'package:command_app_frontend/screens/bookings_table.dart';
import 'package:command_app_frontend/screens/kitchen_table.dart';
import 'package:flutter/material.dart';

import '../widgets/home_page_sections.dart';
import '../widgets/multiple_buttons_page.dart';
import 'waiter_table.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<HomeSection> sections = <HomeSection>[
      HomeSection("Area Servizio", "waiter", () {}),
      HomeSection("Area Cucina", "kitchen", () {}),
      HomeSection("Area Prenotazioni", "bookings", () {}),
    ];

    return HomePageSections(sections);
  }
}

// class AdminHomePage extends StatelessWidget {
//   const AdminHomePage({super.key});
//   static const List<ButtonData> adminPages = [
//     ButtonData("Area servizio", ServiceTable()),
//     ButtonData("Area cucina", KitchenTable()),
//     ButtonData("Area prenotazioni", BookingsTable()),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return const MultipleButtonsPage(adminPages);
//   }
// }