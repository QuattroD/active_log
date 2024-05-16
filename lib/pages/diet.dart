import 'package:active_log/components/horizontal_calendar.dart';
import 'package:flutter/material.dart';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Рацион'),),
      body: Column(
        children: [
          HorizontalCalendar()
        ],
      ),
    ));
  }
}