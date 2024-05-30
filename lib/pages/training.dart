import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Workouts')
                    .doc('yoga_for_beginners')
                    .collection('Exercises')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Ошибка: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('Нет данных'));
                  }

                  final exercises = snapshot.data!.docs.map((doc) {
                    return ListTile(
                      leading: Image(
                        image: NetworkImage(doc['image']),
                      ),
                      title: Text(
                        doc['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('шаг ${doc['step']}'),
                      trailing: Text(doc['time_or_repeats']),
                    );
                  }).toList();
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(
                            child: Image(
                                image: AssetImage('images/exercises.jpeg'))),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10)),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Йога для начинающих',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 15)),
                            Text('15 мин'),
                            Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 5)),
                            Text('Высокая интенсивность')
                          ],
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/training_start');
                              },
                              child: const Text(
                                'Начать',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10)),
                        Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    'Что вы будете делать',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: exercises,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                })));
  }
}
