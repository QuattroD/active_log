import 'package:active_log/services/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool darkTheme = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 251),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Профиль'),
        leading: SizedBox(),
        toolbarHeight: 70,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.black,
              size: 28,
            )),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage('images/niyaz.jpg'),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 70, left: 10),
                    child: Column(
                      children: [
                        const Text(
                          'Нияз Мингазов',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                            FirebaseAuth.instance.currentUser!.email.toString())
                      ],
                    ))
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                Container(
                  width: 80,
                  height: 100,
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(width: 1, color: Colors.grey))),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text('Вес',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 100, 100, 100)))),
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text('52',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold))),
                      Padding(
                          padding: EdgeInsets.only(),
                          child: Text('Кг',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 100, 100, 100))))
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                Container(
                  width: 80,
                  height: 100,
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(width: 1, color: Colors.grey))),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text('Возраст',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 100, 100, 100)))),
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text('20',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold))),
                      Padding(
                          padding: EdgeInsets.only(),
                          child: Text('Лет',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 100, 100, 100))))
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                const SizedBox(
                  width: 80,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text('Рост',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 100, 100, 100)))),
                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text('172',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold))),
                      Padding(
                          padding: EdgeInsets.only(),
                          child: Text('См',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 100, 100, 100))))
                    ],
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            const Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text('Настройки', style: TextStyle(fontSize: 20)))
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 228, 214, 255),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Icon(
                    Icons.mode_night,
                    size: 28,
                    color: Colors.deepPurple,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child:
                        Text('Темный режим', style: TextStyle(fontSize: 20))),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 50)),
                Switch(
                    value: darkTheme,
                    onChanged: (bool value) {
                      setState(() {
                        darkTheme = value;
                      });
                    })
              ],
            ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            GestureDetector(
              onTap: () {},
              child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 214, 255),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Icon(
                      Icons.language,
                      size: 28,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text('Язык', style: TextStyle(fontSize: 20))),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 90)),
                  const Text(
                    'Русский',
                    style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 85, 85, 85)),
                  )
                ],
              ),
            ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            GestureDetector(
              onTap: () {},
              child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 228, 214, 255),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Icon(
                    Icons.notifications_active_outlined,
                    size: 28,
                    color: Colors.deepPurple,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child:
                        Text('Уведомления', style: TextStyle(fontSize: 20))),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 88)),
              ],
            ),
            ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            GestureDetector(
              onTap: () async {
                await UserPreferences.removeUID();
                Navigator.popAndPushNamed(context, '/');
              },
              child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 215, 215),
                      borderRadius: BorderRadius.circular(12)),
                  child:  const Icon(
                    Icons.exit_to_app_outlined,
                    size: 28,
                    color: Colors.red,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child:
                        Text('Выйти из аккаунта', style: TextStyle(fontSize: 20))),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 64)),
              ],
            ),
            ),
            )
          ],
        ),
      ),
    ));
  }
}
