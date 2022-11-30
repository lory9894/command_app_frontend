import 'package:flutter/material.dart';

import '../widgets/multiple_buttons_page.dart';
import 'kitchen_management.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});
  static const List<ButtonData> adminPages = [
    ButtonData("Area prenotazioni", PreparationsTable()),
  ];

  @override
  Widget build(BuildContext context) {
    return const MultipleButtonsPage(adminPages);
  }
}