import 'package:flutter/material.dart';

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({super.key});

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  late String greetingMessage;

  @override
  void initState() {
    super.initState();
    greetingMessage = getGreetingMessage();
  }

  static String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Доброе утро';
    } else if (hour < 18) {
      return 'Добрый день';
    } else {
      return 'Добрый вечер';
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}