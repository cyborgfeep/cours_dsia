import 'package:cours_dsia/utils/constants.dart';
import 'package:flutter/material.dart';

class Option {
  String title;
  IconData icon;
  Color color;

  Option({required this.title, required this.icon, required this.color});

  static List<Option> listOption = [
    Option(title: "Transfert", icon: Icons.person, color: primaryColor),
    Option(
        title: "Paiements",
        icon: Icons.shopping_cart,
        color: Colors.orangeAccent),
    Option(
        title: "Crédit", icon: Icons.phone_android_rounded, color: Colors.blue),
    Option(
        title: "Banque",
        icon: Icons.account_balance_outlined,
        color: Colors.red),
    Option(title: "Cadeaux", icon: Icons.card_giftcard, color: Colors.green),
    Option(
        title: "Transport",
        icon: Icons.bus_alert_outlined,
        color: Colors.deepOrange),
  ];
}
