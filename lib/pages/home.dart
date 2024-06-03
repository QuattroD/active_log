import 'package:active_log/pages/diet.dart';
import 'package:active_log/pages/profile.dart';
import 'package:active_log/pages/report.dart';
import 'package:active_log/pages/start.dart';
import 'package:active_log/services/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int selectedtab = 0;
final tabList = <Widget>[
  const StartPage(),
  const DietPage(),
  const ReportPage(),
  const ProfilePage()
];

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    UserPreferences.saveUserUid(FirebaseAuth.instance.currentUser!.uid.toString());
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[200],
      body: tabList.elementAt(selectedtab),
      bottomNavigationBar: GNav(
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
          ]),
    ));
  }
}
