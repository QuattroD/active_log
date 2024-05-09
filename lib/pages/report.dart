import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  List<double> weeklySummary = [
    34.40,
    15.50,
    45.42,
    35.50,
    60.20,
    50.99,
    90.10
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SizedBox());
  }
}
