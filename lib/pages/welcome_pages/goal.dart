import 'package:active_log/services/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoalPage extends StatefulWidget {
  const GoalPage({super.key});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  bool isloseWeight = false;
  bool isGainMuscle = false;
  bool isGetFitter = false;
  double widthContainerloseWeight = 160;
  double heightContainerloseWeight = 180;
  double widthContainerGainMuscle = 160;
  double heightContainerGainMuscle = 180;
  double widthContainerGetFitter = 160;
  double heightContainerGetFitter = 180;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Какова ваша цель?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Text(
              'Это используется для персонализированных результатов и составления планов для вас',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey[800]),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isloseWeight = true;
                      isGainMuscle = false;
                      isGetFitter = false;
                    });
                  },
                  child: Container(
                    width: isloseWeight
                        ? widthContainerloseWeight + 20
                        : widthContainerloseWeight,
                    height: isloseWeight
                        ? heightContainerloseWeight + 20
                        : heightContainerloseWeight,
                    decoration: BoxDecoration(
                        color: isloseWeight
                            ? Colors.deepPurple
                            : const Color.fromARGB(255, 242, 236, 255),
                        border: Border.all(
                          width: 1,
                          color: isloseWeight
                              ? Colors.deepPurple
                              : const Color.fromARGB(255, 242, 236, 255),
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/medical.png',
                            width: 40,
                            color:
                                isloseWeight ? Colors.white : Colors.grey[700]),
                        Text(
                          'Сбросить вес',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: isloseWeight
                                  ? Colors.white
                                  : Colors.grey[700],
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isloseWeight = false;
                      isGainMuscle = false;
                      isGetFitter = true;
                    });
                  },
                  child: Container(
                    width: isGetFitter
                        ? widthContainerGetFitter + 20
                        : widthContainerGetFitter,
                    height: isGetFitter
                        ? heightContainerGetFitter + 20
                        : heightContainerGetFitter,
                    decoration: BoxDecoration(
                        color: isGetFitter
                            ? Colors.deepPurple
                            : const Color.fromARGB(255, 242, 236, 255),
                        border: Border.all(
                          width: 1,
                          color: isGetFitter
                              ? Colors.deepPurple
                              : const Color.fromARGB(255, 242, 236, 255),
                        ),
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/fit.png',
                            width: 40,
                            color:
                                isGetFitter ? Colors.white : Colors.grey[700]),
                        Text(
                          'Быть в форме',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:
                                  isGetFitter ? Colors.white : Colors.grey[700],
                              fontSize: 20),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            GestureDetector(
              onTap: () {
                setState(() {
                  isloseWeight = false;
                  isGainMuscle = true;
                  isGetFitter = false;
                });
              },
              child: Container(
                width: isGainMuscle
                    ? widthContainerGainMuscle + 20
                    : widthContainerGainMuscle,
                height: isGainMuscle
                    ? heightContainerGainMuscle + 20
                    : heightContainerGainMuscle,
                decoration: BoxDecoration(
                    color: isGainMuscle
                        ? Colors.deepPurple
                        : const Color.fromARGB(255, 242, 236, 255),
                    border: Border.all(
                      width: 1,
                      color: isGainMuscle
                          ? Colors.deepPurple
                          : const Color.fromARGB(255, 242, 236, 255),
                    ),
                    borderRadius: BorderRadius.circular(50)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/muscle.png',
                        width: 40,
                        color: isGainMuscle ? Colors.white : Colors.grey[700]),
                    Text(
                      'Набрать массу',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: isGainMuscle ? Colors.white : Colors.grey[700],
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 50)),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 100,
        decoration: const BoxDecoration(color: Colors.deepPurple),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, '/tall');
              },
              child: const Text(
                'Назад',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Container(
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(15)),
              child: TextButton(
                  onPressed: () async {
                    if (isGainMuscle == false &&
                        isGetFitter == false &&
                        isloseWeight == false) {
                    } else {
                      if (isGainMuscle == true) {
                        UserPreferences.saveUserGoal('Набрать массу');
                      } else if (isGetFitter == true) {
                        UserPreferences.saveUserGoal(
                            'Поддерживать себя в форме');
                      } else if (isloseWeight == true) {
                        UserPreferences.saveUserGoal('Сбросить вес');
                      }
                      FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).doc(FirebaseAuth.instance.currentUser!.uid.toString()).update({
                        'age': await UserPreferences.getUserAge(),
                        'gender': await UserPreferences.getUserGender(),
                        'weight': await UserPreferences.getUserWeight(),
                        'tall': await UserPreferences.getUserTall(),
                        'goal': await UserPreferences.getUserGoal()
                      });
                      Navigator.pushNamed(context, '/home');
                    }
                  },
                  child: const Text(
                    'Закончить',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
