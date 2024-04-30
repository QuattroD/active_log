import 'package:active_log/components/navigation_bar.dart';
import 'package:active_log/pages/diet.dart';
import 'package:active_log/pages/profile.dart';
import 'package:active_log/pages/report.dart';
import 'package:active_log/pages/start.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final tabList = <Widget>[
  StartPage(),
  DietPage(),
  ReportPage(),
  ProfilePage()
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Активность'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_month))
        ],
      ),
      body: tabList.elementAt(0),
      bottomNavigationBar: NavigationBarPage(),
    ));
  }
}
