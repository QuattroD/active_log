import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Профиль'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black), borderRadius: BorderRadius.circular(100)),
            ),
            Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.01)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: const TextField(
                //controller: ,
                decoration: InputDecoration(
                    hintText: 'Имя',
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
                            vertical:
                                MediaQuery.of(context).size.height * 0.01)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: const TextField(
                //controller: ,
                decoration: InputDecoration(
                    hintText: 'Возраст',
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
                            vertical:
                                MediaQuery.of(context).size.height * 0.01)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: const TextField(
                //controller: ,
                decoration: InputDecoration(
                    hintText: 'Пол',
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
                            vertical:
                                MediaQuery.of(context).size.height * 0.01)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: const TextField(
                //controller: ,
                decoration: InputDecoration(
                    hintText: 'Рост',
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
                            vertical:
                                MediaQuery.of(context).size.height * 0.01)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: const TextField(
                //controller: ,
                decoration: InputDecoration(
                    hintText: 'Вес',
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
                          onPressed: () {
                          },
                          child: const Text(
                            'Войти',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )),
                    ),
          ],
        ),
      ),
    ));
  }
}
