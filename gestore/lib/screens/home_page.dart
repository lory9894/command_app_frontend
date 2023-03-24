import 'package:command_app_frontend/screens/bookings_table.dart';
import 'package:command_app_frontend/screens/kitchen_table.dart';
import 'package:flutter/material.dart';

import '../widgets/home_page_sections.dart';
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
      HomeSection("Area Servizio", "waiter", () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const WaiterTable()),
        );
      }),
      HomeSection("Area Cucina", "kitchen", () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const KitchenTable()),
        );
      }),
      HomeSection("Area Prenotazioni", "bookings", () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const BookingsTable()),
        );
      }),
    ];

    return HomePageSections(sections);
  }
}