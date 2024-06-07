import 'package:active_log/components/card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late String _greetingMessage;
  @override
  void initState() {
    super.initState();
    _greetingMessage = _getGreetingMessage();
    createDocumentIfNotExists();
  }

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Доброе утро';
    } else if (hour < 18) {
      return 'Добрый день';
    } else {
      return 'Добрый вечер';
    }
  }

  Future<void> createDocumentIfNotExists() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.email.toString())
          .where('date', isEqualTo: '$todayDate 00:00:00.000')
          .get();

      if (querySnapshot.docs.isEmpty) {
        await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).add({
          'calories': 0,
          'carbs': 0,
          'date': '$todayDate 00:00:00.000',
          'fat': 0,
          'fiber': 0,
          'protein': 0,
          'steps': 0,
          'water': 0,
          'workouts': 0,
        });
        print('New document created');
      } else {
        print('Document with today\'s date already exists');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(children: [
                Text(
                  '$_greetingMessage, ${FirebaseAuth.instance.currentUser!.displayName.toString()}',
                  style: const TextStyle(fontSize: 24),
                ),
              ])),
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01)),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Row(children: [
                Text(
                  'Недавняя активность',
                  style: TextStyle(fontSize: 20),
                )
              ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, '/activity');
                },
                child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(width: 1, color: Colors.orange),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 4, color: Colors.white),
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Icon(
                                Icons.directions_run,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    0.005)),
                        const Text(
                          'Активность',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ],
                    ))),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, '/workout');
                },
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      border: Border.all(width: 1, color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Center(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 4, color: Colors.white),
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(
                              Icons.directions_bike,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.005)),
                      const Text(
                        'Тренировки',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ))),
                ),
              )
            ],
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Row(children: [
                Text(
                  'Популярные упражнения',
                  style: TextStyle(fontSize: 20),
                )
              ])),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
            child: const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  //ExerciseCard(background: Colors.lightBlue, title: 'title'),
                  //ExerciseCard(background: Colors.green, title: 'title2')
                ],
              ),
            ),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const Row(children: [
                Text(
                  'Процесс тренировки',
                  style: TextStyle(fontSize: 20),
                )
              ])),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
            height: MediaQuery.of(context).size.height * 0.2,
            child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InfoCard(
                        background: Color.fromARGB(255, 231, 231, 231),
                        icon: Icons.directions_run,
                        widget: Text('2345 шагов'),
                        title: 'Ходьба',
                        iconColor: Colors.deepPurple,
                        textColor: Colors.black,
                        height: 50),
                    InfoCard(
                        background: Color.fromARGB(255, 231, 231, 231),
                        icon: Icons.accessibility_new,
                        widget: Text('3 часа'),
                        title: 'Упражнения',
                        iconColor: Colors.cyan,
                        textColor: Colors.black,
                        height: 50),
                    InfoCard(
                        background: Color.fromARGB(255, 231, 231, 231),
                        icon: Icons.directions_bike,
                        widget: Text('3 часа'),
                        title: 'Велоспорт',
                        iconColor: Colors.orange,
                        textColor: Colors.black,
                        height: 50)
                  ],
                )),
          )
        ],
      ),
    ));
  }
}
