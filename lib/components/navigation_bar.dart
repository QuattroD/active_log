import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int selectedtab = 0;
  @override
  Widget build(BuildContext context) {
    return GNav(
        gap: 8,
        backgroundColor: Colors.white,
        color: Colors.grey[600],
        activeColor: Colors.deepPurple,
        selectedIndex: selectedtab,
        onTabChange: (index) {
          setState(() {
            selectedtab = index;
          });
        },
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Главная',
          ),
          GButton(
            icon: Icons.restaurant_menu,
            text: 'Рацион',
          ),
          GButton(
            icon: Icons.donut_large,
            text: 'Статистика',
          ),
          GButton(
            icon: Icons.account_box,
            text: 'Профиль',
          ),
        ]);
  }
}
