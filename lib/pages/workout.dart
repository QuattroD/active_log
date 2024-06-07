import 'package:active_log/components/exercise_card.dart';
import 'package:active_log/pages/training.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  String workoutFilter = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80,
          centerTitle: true,
          title: const Text('Ежедневные тренировки'),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.93,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Категории',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        workoutFilter = '';
                      });
                    },
                    child: const Text(
                      'Сбросить',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  categoryFilterButton(
                      'Йога', 'yoga', 'images/yoga_exercise.png'),
                  categoryFilterButton(
                      'Силовые', 'strength', 'images/strength.png'),
                  categoryFilterButton('Кардио', 'cardio', 'images/cardio.png'),
                  categoryFilterButton(
                      'Растяжка', 'stretching', 'images/stretching.png'),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.93,
              child: const Row(
                children: [
                  Text(
                    'Популярные тренировки',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: workoutFilter.isNotEmpty
                    ? FirebaseFirestore.instance
                        .collection('Workouts')
                        .where('type', isEqualTo: workoutFilter)
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('Workouts')
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Ошибка: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'К сожалению по вашему запросу,\nничего не найдено :(',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }

                  final workouts = snapshot.data!.docs.map((doc) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TrainingPage(workoutId: doc.id),
                          ),
                        );
                      },
                      child: ExerciseCard(
                        background: const Color.fromARGB(255, 196, 231, 255),
                        title: doc['title'],
                        imageURL: doc['image'],
                        kcal: doc['kcal'],
                        time: doc['time'],
                      ),
                    );
                  }).toList();

                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: workouts,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryFilterButton(String title, String filter, String image) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              workoutFilter = filter;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.09,
            decoration: BoxDecoration(
              color: workoutFilter == filter
                  ? Colors.deepPurple
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                width: 1,
                color: workoutFilter == filter
                    ? Colors.deepPurple
                    : const Color.fromARGB(255, 226, 226, 226),
              ),
            ),
            child: Center(
              child: Stack(
                children: [
                  Image(
                    image: AssetImage(image),
                    width: 45,
                    color:
                        workoutFilter == filter ? Colors.white : Colors.black,
                  )
                ],
              ),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
        Text(title)
      ],
    );
  }
}
