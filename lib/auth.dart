import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01)),
            Image.asset('images/logo.png', width: 150, height: 150,),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Text(
                'Авторизация',
                style: TextStyle(color: Colors.black, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                    hintText: 'Введите email',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: TextField(
                obscureText: isObscure,
                controller: password,
                decoration: InputDecoration(
                    hintText: 'Введите пароль',
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (isObscure == true) {
                            isObscure = false;
                          } else {
                            isObscure = true;
                          }
                        });
                      },
                      icon: isObscure == true
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    )),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.005)),
            Container(
                alignment: const Alignment(0.85, 0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Text('Забыли пароль?'),
                )),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01)),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Войти',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 1,
                    width: 100,
                    decoration: BoxDecoration(color: Colors.grey.shade400),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01)),
                  const Text(
                    'Или продолжить с',
                    style: TextStyle(fontSize: 15),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.03)),
                  Container(
                    height: 1,
                    width: 100,
                    decoration: BoxDecoration(color: Colors.grey.shade400),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02)),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Войти',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02)),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Войти',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Нет аккаунта? ',
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/reg');
                  },
                  child: const Text(
                    'Зарегистрироваться сейчас?',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
