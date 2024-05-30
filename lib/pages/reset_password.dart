import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(elevation: 0,),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Восстановление пароля'),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                    hintText: 'Введите свою почту',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color:Colors.grey,
                        ),
                        borderRadius:
                            BorderRadius.all(Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color:Colors.grey,
                        ),
                        borderRadius:
                            BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
              child: TextButton(onPressed: () async {
                await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
              }, child: Text('Отправить письмо')),
            )
        ],),),
    ));
  }
}