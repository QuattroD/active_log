import 'package:flutter/material.dart';
import 'package:active_log/services/firebase_services.dart';
import 'package:active_log/services/user_model.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

FirebaseService firebaseService = FirebaseService();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
bool isObscure = true;

class _AuthPageState extends State<AuthPage> {
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
                            vertical:
                                MediaQuery.of(context).size.height * 0.01)),
                    const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/activelog.png'),
                  width: 70,
                ),
                Text(
                  'ActiveLog',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.01)),
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
                            vertical:
                                MediaQuery.of(context).size.height * 0.01)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: TextField(
                        controller: email,
                        decoration: const InputDecoration(
                            hintText: 'Введите email',
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.01)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: TextField(
                        obscureText: isObscure,
                        controller: password,
                        decoration: InputDecoration(
                            hintText: 'Введите пароль',
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
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
                            vertical:
                                MediaQuery.of(context).size.height * 0.005)),
                    Container(
                        alignment: const Alignment(0.85, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/reset_password');
                          },
                          child: const Text('Забыли пароль?'),
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.01)),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 138, 57, 225),
                            Color.fromARGB(255, 111, 58, 121),
                          ], stops: [
                            0.2,
                            1.0
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TextButton(
                          onPressed: () async {
                            UserModel? user = await firebaseService.signIn(
                                email.text, password.text);
                            if (user != null) {
                              Navigator.pushNamed(context, '/home');
                            } else {
                              return;
                            }
                          },
                          child: const Text(
                            'Войти',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.01)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 1,
                            width: 100,
                            decoration:
                                BoxDecoration(color: Colors.grey.shade400),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.01)),
                          const Text(
                            'Или продолжить с',
                            style: TextStyle(fontSize: 15),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.03)),
                          Container(
                            height: 1,
                            width: 100,
                            decoration:
                                BoxDecoration(color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.02)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            firebaseService.signInWithGoogle();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey[200],
                            ),
                            child: Image.asset(
                              'images/google-logo.png',
                              height: 40,
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        GestureDetector(
                          onTap: () {
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey[200],
                            ),
                            child: Image.asset(
                              'images/apple-logo.png',
                              height: 40,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.02)),
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
