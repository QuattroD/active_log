import 'package:flutter/material.dart';

class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});
  
  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'СМС Верификация',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Text(
                    'Для проверки вашего зарегистрированного телефонного номера был отправлен 6-значный код.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 25)),
                 
                ],
              ),
            )));
  }
}
