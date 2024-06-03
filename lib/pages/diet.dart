import 'package:active_log/components/horizontal_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  DateTime? _selectedDate;

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
        title: const Text('Ежедневный рацион'),
        leading: const SizedBox(),
        toolbarHeight: 70,
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
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
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: const Row(
              children: [
                Text(
                  'Рацион питания',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(
                      FirebaseAuth.instance.currentUser!.email.toString())
                  .where('date', isEqualTo: _selectedDate.toString())
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
                  ));
                }
                var snap = snapshot.data!.docs;
                return Column(children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.89,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: Colors.white)),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  'Потреблено сегодня',
                                  style: TextStyle(fontSize: 17),
                                ),
                              )
                            ],
                          ),
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  '518 / 2,500 калорий',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.83,
                            height: MediaQuery.of(context).size.height * 0.01,
                            child: const LinearProgressIndicator(
                              value: 0.4,
                              color: Colors.green,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
                        ],
                      )),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: MediaQuery.of(context).size.height * 0.11,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Row(
                              children: [
                                const Column(
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.only(left: 20, top: 20),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(
                                            value: 0.65,
                                            strokeWidth: 7,
                                            color: Colors.cyan,
                                            backgroundColor: Color.fromARGB(
                                                255, 211, 211, 211),
                                          ),
                                        ))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 22),
                                      child: SizedBox(
                                        child: Text('Белки'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: SizedBox(
                                        child: Text('${snap[0]['protein']}г'),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: MediaQuery.of(context).size.height * 0.11,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 20),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(
                                            value: 0.15,
                                            strokeWidth: 7,
                                            color: Colors.orange,
                                            backgroundColor: Colors.grey[300],
                                          ),
                                        ))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 22),
                                      child: SizedBox(
                                        child: Text('Жиры'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: SizedBox(
                                        child: Text('${snap[0]['fat']}г'),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: MediaQuery.of(context).size.height * 0.11,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 20),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(
                                            value: 0.3,
                                            strokeWidth: 7,
                                            color: Colors.amber,
                                            backgroundColor: Colors.grey[300],
                                          ),
                                        ))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 22),
                                      child: SizedBox(
                                        child: Text('Углеводы'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: SizedBox(
                                        child: Text('${snap[0]['carbs']}г'),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: MediaQuery.of(context).size.height * 0.11,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, top: 20),
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(
                                            value: 0.9,
                                            strokeWidth: 7,
                                            color: Colors.deepPurple,
                                            backgroundColor: Colors.grey[300],
                                          ),
                                        ))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 22),
                                      child: SizedBox(
                                        child: Text('Клетчатка'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: SizedBox(
                                        child: Text('${snap[0]['fiber']}г'),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ]);
              }),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Container(
            width: MediaQuery.of(context).size.width * 0.89,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(10)),
            child: TextButton(
                onPressed: () {
                  Scaffold.of(context).showBottomSheet(
                    (BuildContext context) {
                      return Container(
                        height: 350,
                        color: Colors.grey[100],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 350,
                                child: TextField(
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      hintText: 'Имя продукта',
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2, color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 2, color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 163,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: 'Белки',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))),
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10)),
                                  SizedBox(
                                    width: 163,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: 'Жиры',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 163,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: 'Углеводы',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))),
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10)),
                                  SizedBox(
                                    width: 163,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: 'Клетчатка',
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2, color: Colors.grey),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              Container(
                                width: 342,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Добавить',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text(
                  '+Добавить питание',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          )
        ],
      ),
    ));
  }
}
