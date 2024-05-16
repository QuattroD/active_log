import 'package:active_log/components/exercise_card.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text('Ежедневные тренировки'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Column(
        children: [
          const Text(
            'Категории',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 226, 226, 226))),
                    child: const Center(
                      child: Stack(
                        children: [
                          Icon(
                            Icons.accessibility_new,
                            size: 35,
                          )
                        ],
                      ),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 226, 226, 226))),
                    child: const Center(
                      child: Stack(
                        children: [
                          Icon(
                            Icons.pool,
                            size: 35,
                          )
                        ],
                      ),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 226, 226, 226))),
                    child: const Center(
                      child: Stack(
                        children: [
                          Icon(
                            Icons.pedal_bike_outlined,
                            size: 35,
                          )
                        ],
                      ),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 226, 226, 226))),
                    child: const Center(
                      child: Stack(
                        children: [
                          Icon(
                            Icons.directions_run,
                            size: 35,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
          const Text(
            'Популярные тренировки',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          ExerciseCard(background: Colors.lightBlue, title: 'title'),
          ExerciseCard(background: Colors.green, title: 'title2'),
          ExerciseCard(background: Colors.orange, title: 'title3')
        ],
      ),
    ));
  }
}
