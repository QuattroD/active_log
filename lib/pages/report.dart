import 'package:active_log/components/horizontal_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _selectedDate = DateTime(now.year, now.month, now.day);
  }

  void _handleDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      print(_selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 245, 245, 251),
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text('Статистика'),
              leading: const SizedBox(),
              toolbarHeight: 70,
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                'Сегодня ${DateFormat.yMMMMd('ru').format(DateTime.now())}',
                                style: const TextStyle(fontSize: 17),
                              ),
                            )
                          ],
                        ),
                        HorizontalCalendar(onDateSelected: _handleDateSelected),
                      ],
                    )),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(
                          FirebaseAuth.instance.currentUser!.email.toString())
                      .where('date', isEqualTo: _selectedDate.toString())
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Ошибка: ${snapshot.error}'));
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
                    var snap = snapshot.data!.docs;
                    return Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5)),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 55,
                                          height: 55,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 255, 219, 215),
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              border: Border.all(
                                                  width: 1,
                                                  color: const Color.fromARGB(
                                                      255, 255, 219, 215))),
                                          child: const Icon(
                                            Icons
                                                .local_fire_department_outlined,
                                            color: Colors.red,
                                            size: 35,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Сожжено',
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${snap[0]['calories']}ккал',
                                            style:
                                                const TextStyle(fontSize: 25),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10)),
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 55,
                                          height: 55,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 213, 229, 255),
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              border: Border.all(
                                                  width: 1,
                                                  color: const Color.fromARGB(
                                                      255, 213, 229, 255))),
                                          child: const Icon(
                                            Icons.water_drop,
                                            color: Colors.blue,
                                            size: 35,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Выпито воды',
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${snap[0]['water']}мл',
                                            style:
                                                const TextStyle(fontSize: 25),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 55,
                                          height: 55,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 255, 239, 214),
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              border: Border.all(
                                                  width: 1,
                                                  color: const Color.fromARGB(
                                                      255, 255, 239, 214))),
                                          child: const Icon(
                                            Icons.directions_run,
                                            color: Colors.orange,
                                            size: 35,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Тренировки',
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${snap[0]['workouts']} час',
                                            style:
                                                const TextStyle(fontSize: 25),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10)),
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 55,
                                          height: 55,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 229, 213, 255),
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              border: Border.all(
                                                  width: 1,
                                                  color: const Color.fromARGB(
                                                      255, 229, 213, 255))),
                                          child: const Icon(
                                            Icons.monitor_weight,
                                            color: Colors.deepPurple,
                                            size: 35,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Текущий вес',
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ],
                                      )),
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(top: 5, left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            '52кг',
                                            style: TextStyle(fontSize: 25),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10)),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 1, color: Colors.white),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Трекер шагов',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 60)),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        'Детали >',
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 17),
                                      ),
                                    )
                                  ],
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10)),
                                const Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: CircularProgressIndicator(
                                        value: 0.9,
                                        color: Colors.green,
                                        strokeWidth: 10,
                                        backgroundColor:
                                            Color.fromARGB(255, 211, 211, 211),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.directions_run,
                                          size: 40,
                                        ),
                                        Text('5102/7000'),
                                        Text('шагов')
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10)),
                      ],
                    );
                  },
                )
              ],
            ))));
  }
}
