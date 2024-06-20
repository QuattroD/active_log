import 'package:active_log/services/firebase_services.dart';
import 'package:active_log/services/user_model.dart';
import 'package:flutter/material.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final RegExp _emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  final RegExp _phoneRegExp = RegExp(r'^\+?[0-9]{7,15}$');
  FirebaseService firebaseService = FirebaseService();
  TextEditingController name = TextEditingController();
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isObscure = true;
  String _inputType = '';

  void _checkInput(String input) {
    setState(() {
      if (_emailRegExp.hasMatch(input)) {
        _inputType = 'Email';
      } else if (_phoneRegExp.hasMatch(input)) {
        _inputType = 'Phone';
      } else {
        _inputType = 'Invalid';
      }
    });
  }

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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/activelog.png'),
                  width: 70,
                ),
                Text(
                  'Трекер дня',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Text(
                'Регистрация',
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
                controller: name,
                decoration: const InputDecoration(
                    hintText: 'Введите имя',
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
                controller: login,
                decoration: const InputDecoration(
                    hintText: 'Введите почту',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.grey,
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
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: TextField(
                obscureText: isObscure,
                controller: password,
                decoration: const InputDecoration(
                  hintText: 'Введите пароль',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: TextField(
                obscureText: isObscure,
                controller: confirmPassword,
                decoration: InputDecoration(
                    hintText: 'Подтвердите пароль',
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
                    vertical: MediaQuery.of(context).size.height * 0.01)),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextButton(
                  onPressed: () async {
                    if (password.text == confirmPassword.text) {
                      if (_inputType == 'Email') {
                        UserModel? user = await firebaseService.signUpEmail(
                            name.text, login.text, password.text);
                        if (user != null) {
                          Navigator.pushNamed(context, '/verification_email');
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Письмо с подтверждением отправлено. Проверьте вашу почту.')));
                        } else {
                          return;
                        }
                      } else if (_inputType == 'Phone') {                        
                      } else {}
                    }
                  },
                  child: const Text(
                    'Зарегистрироваться',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    firebaseService.signInWithGoogle(context);
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
                      height: 50,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Есть аккаунта? ',
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text(
                    'Войти сейчас?',
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
