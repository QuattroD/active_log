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
    TextEditingController proteinController = TextEditingController();
    TextEditingController fatController = TextEditingController();
    TextEditingController carbsController = TextEditingController();
    TextEditingController fiberController = TextEditingController();
    TextEditingController waterController = TextEditingController();
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
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection(FirebaseAuth.instance.currentUser!.email.toString())
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, userSnapshot) {
              if (userSnapshot.hasError) {
                return Center(child: Text('Ошибка: ${userSnapshot.error}'));
              }
              if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                return const Center(
                  child: Text(
                    'Не удалось загрузить данные пользователя.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }

              var userData = userSnapshot.data!;
              var userGoal = userData['goal'];
              var age = userData['age'];
              var weight = userData['weight'];
              var height = userData['tall'];
              var gender = userData['gender'];

              double bmr;
              if (gender == 'Мужской') {
                bmr = 10 * weight + 6.25 * height - 5 * age + 5;
              } else {
                bmr = 10 * weight + 6.25 * height - 5 * age - 161;
              }

              double tdee = bmr;
              double proteinTarget;
              double fatTarget;
              double carbsTarget;
              double waterTarget = 30.0 * weight;
              switch (userGoal) {
                case 'Сбросить вес':
                  proteinTarget = weight * 2.0;
                  fatTarget = weight * 0.8;
                  carbsTarget =
                      (tdee - (proteinTarget * 4 + fatTarget * 9)) / 4;
                  break;
                case 'Набрать массу':
                  proteinTarget = weight * 2.2;
                  fatTarget = weight * 1.0;
                  carbsTarget =
                      (tdee - (proteinTarget * 4 + fatTarget * 9)) / 4;
                  break;
                case 'Поддерживать себя в форме':
                default:
                  proteinTarget = weight * 1.8;
                  fatTarget = weight * 0.9;
                  carbsTarget =
                      (tdee - (proteinTarget * 4 + fatTarget * 9)) / 4;
                  break;
              }
              return StreamBuilder<QuerySnapshot>(
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

                  double proteinPercentage = snap[0]['protein'] / proteinTarget;
                  double fatPercentage = snap[0]['fat'] / fatTarget;
                  double carbsPercentage = snap[0]['carbs'] / carbsTarget;
                  double fiberPercentage = snap[0]['fiber'] / 25;

                  return Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.89,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  'Калорийность за день',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  '${snap[0]['calories']} / ${tdee.round()} калорий',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.83,
                            height: MediaQuery.of(context).size.height * 0.01,
                            child: LinearProgressIndicator(
                              value: snap[0]['calories'] / tdee,
                              color: Colors.green,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5)),
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  'Сегодняшний объем воды',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  '${snap[0]['water']} / ${waterTarget.round()} мл',
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.83,
                            height: MediaQuery.of(context).size.height * 0.01,
                            child: LinearProgressIndicator(
                              value: snap[0]['water'] / waterTarget,
                              color: Colors.cyan,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10)),
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
                              border: Border.all(width: 1, color: Colors.white),
                            ),
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
                                          value: proteinPercentage,
                                          strokeWidth: 7,
                                          color: Colors.cyan,
                                          backgroundColor: const Color.fromARGB(
                                              255, 211, 211, 211),
                                        ),
                                      ),
                                    ),
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
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        child: Text(
                                            '${snap[0]['protein']}г / ${proteinTarget.round()}г'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: MediaQuery.of(context).size.height * 0.11,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 1, color: Colors.white),
                            ),
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
                                          value: fatPercentage,
                                          strokeWidth: 7,
                                          color: Colors.orange,
                                          backgroundColor: Colors.grey[300],
                                        ),
                                      ),
                                    ),
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
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        child: Text(
                                            '${snap[0]['fat']}г / ${fatTarget.round()}г'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                              border: Border.all(width: 1, color: Colors.white),
                            ),
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
                                          value: carbsPercentage,
                                          strokeWidth: 7,
                                          color: Colors.amber,
                                          backgroundColor: Colors.grey[300],
                                        ),
                                      ),
                                    ),
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
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        child: Text(
                                            '${snap[0]['carbs']}г / ${carbsTarget.round()}г'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: MediaQuery.of(context).size.height * 0.11,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 1, color: Colors.white),
                            ),
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
                                          value: fiberPercentage,
                                          strokeWidth: 7,
                                          color: Colors.deepPurple,
                                          backgroundColor: Colors.grey[300],
                                        ),
                                      ),
                                    ),
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
                                      padding: const EdgeInsets.only(left: 20),
                                      child: SizedBox(
                                        child:
                                            Text('${snap[0]['fiber']}г / 25г'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
                },
              );
            },
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.43,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 163,
                                        child: TextField(
                                          controller: proteinController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              hintText: 'Белки',
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10)))),
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10)),
                                      SizedBox(
                                        width: 163,
                                        child: TextField(
                                          controller: fatController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              hintText: 'Жиры',
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10)))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 163,
                                        child: TextField(
                                          controller: carbsController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              hintText: 'Углеводы',
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10)))),
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10)),
                                      SizedBox(
                                        width: 163,
                                        child: TextField(
                                          controller: fiberController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              hintText: 'Клетчатка',
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10)))),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10)),
                                  Container(
                                    width: 342,
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurple,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextButton(
                                      onPressed: () async {
                                        String email = FirebaseAuth
                                            .instance.currentUser!.email
                                            .toString();
                                        String selectedDate =
                                            _selectedDate.toString();

                                        int protein =
                                            int.parse(proteinController.text);
                                        int fat = int.parse(fatController.text);
                                        int carbs =
                                            int.parse(carbsController.text);
                                        int fiber =
                                            int.parse(fiberController.text);

                                        int totalCalories = (protein * 4) +
                                            (fat * 9) +
                                            (carbs * 4) +
                                            (fiber * 2);
                                        QuerySnapshot querySnapshot =
                                            await FirebaseFirestore.instance
                                                .collection(email)
                                                .where('date',
                                                    isEqualTo: selectedDate)
                                                .get();

                                        if (querySnapshot.docs.isNotEmpty) {
                                          DocumentSnapshot doc =
                                              querySnapshot.docs[0];
                                          FirebaseFirestore.instance
                                              .collection(email)
                                              .doc(doc.id)
                                              .update({
                                                'protein': FieldValue.increment(
                                                    protein),
                                                'fat':
                                                    FieldValue.increment(fat),
                                                'carbs':
                                                    FieldValue.increment(carbs),
                                                'fiber':
                                                    FieldValue.increment(fiber),
                                                'calories':
                                                    FieldValue.increment(
                                                        totalCalories),
                                              })
                                              .then((_) => print(
                                                  'Данные успешно обновлены'))
                                              .catchError((error) => print(
                                                  'Ошибка при обновлении данных: $error'));
                                        } else {
                                          FirebaseFirestore.instance
                                              .collection(email)
                                              .add({
                                                'date': selectedDate,
                                                'protein': protein,
                                                'fat': fat,
                                                'carbs': carbs,
                                                'fiber': fiber,
                                                'calories': totalCalories,
                                              })
                                              .then((_) => print(
                                                  'Документ успешно создан'))
                                              .catchError((error) => print(
                                                  'Ошибка при создании документа: $error'));
                                        }
                                        proteinController.text = '';
                                        fatController.text = '';
                                        carbsController.text = '';
                                        fiberController.text = '';
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Добавить',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Добавить',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Icon(
                          Icons.restaurant_menu,
                          color: Colors.white,
                        )
                      ],
                    )),
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Container(
                width: MediaQuery.of(context).size.width * 0.43,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                    color: Colors.blue[700],
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).showBottomSheet(
                        (BuildContext context) {
                          return Container(
                            height: 200,
                            color: Colors.grey[100],
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 350,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: waterController,
                                      decoration: const InputDecoration(
                                          hintText: 'Объём воды',
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10)),
                                  Container(
                                    width: 342,
                                    decoration: BoxDecoration(
                                        color: Colors.blue[700],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextButton(
                                      onPressed: () async {
                                        String email = FirebaseAuth
                                            .instance.currentUser!.email.toString();
                                        String selectedDate = _selectedDate.toString();
                                        int water =
                                            int.parse(waterController.text);
                                        QuerySnapshot querySnapshot =
                                            await FirebaseFirestore.instance
                                                .collection(email)
                                                .where('date',
                                                    isEqualTo: selectedDate)
                                                .get();

                                        if (querySnapshot.docs.isNotEmpty) {
                                          DocumentSnapshot doc =
                                              querySnapshot.docs[0];
                                          FirebaseFirestore.instance
                                              .collection(email)
                                              .doc(doc.id)
                                              .update({
                                                'water': FieldValue.increment(water),
                                              })
                                              .then((_) => print(
                                                  'Данные успешно обновлены'))
                                              .catchError((error) => print(
                                                  'Ошибка при обновлении данных: $error'));
                                        } else {
                                          FirebaseFirestore.instance
                                              .collection(email)
                                              .add({
                                                'water': water,
                                              })
                                              .then((_) => print(
                                                  'Документ успешно создан'))
                                              .catchError((error) => print(
                                                  'Ошибка при создании документа: $error'));
                                        }
                                        proteinController.text = '';
                                        fatController.text = '';
                                        carbsController.text = '';
                                        fiberController.text = '';
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Добавить',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Добавить',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Icon(
                          Icons.water_drop,
                          color: Colors.white,
                          size: 28,
                        )
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    ));
  }
}
