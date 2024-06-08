import 'package:active_log/pages/training_start.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrainingPage extends StatefulWidget {
  final String workoutId;
  const TrainingPage({super.key, required this.workoutId});

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
                    .doc(widget.workoutId)
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
                      trailing: doc['repeats'] ? Text('x${doc['time_or_repeats']}') : Text('${doc['time_or_repeats']} сек'),
                    );
                  }).toList();
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Workouts')
                        .doc(widget.workoutId)
                        .snapshots(),
                    builder: (context, workoutinfo) {
                      if (workoutinfo.hasError) {
                        return Center(
                            child: Text('Ошибка: ${workoutinfo.error}'));
                      }
                      if (workoutinfo.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!workoutinfo.hasData || !workoutinfo.data!.exists) {
                        return const Center(
                          child: Text(
                            'Не удалось загрузить данные пользователя.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }
                      var workout = workoutinfo.data!;
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                                child: Image(
                                    image:
                                        NetworkImage('${workout['image']}'))),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10)),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    '${workout['title']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(left: 15)),
                                Text(
                                  '${workout['time']} мин',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5)),
                                Text(
                                  '${workout['kcal']} ккал',
                                  style: const TextStyle(fontSize: 18),
                                ),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TrainingStartPage(workoutId: widget.workoutId),
                                      ),
                                    );
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
                    },
                  );
                })));
  }
}
