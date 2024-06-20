import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
            ),
            body: Center(
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 40)),
                  Image.asset(
                    'images/verification-email.png',
                    width: 300,
                    height: 300,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  const Text('Проверьте свою почту',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Text('Здесь вы можете проверить свою почту',
                      style: TextStyle(color: Colors.grey[700], fontSize: 20)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30)),
                    child: TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.currentUser!.reload();
                        await Future.delayed(const Duration(
                            seconds:
                                2)); // Add a delay to ensure the status is updated
                        if (FirebaseAuth.instance.currentUser!.emailVerified) {
                          Navigator.pushNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                'Пожалуйста, подтвердите ваш почтовый адрес.'),
                          ));
                        }
                      },
                      child: const Text(
                        'Проверить почту',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
