import 'package:active_log/services/user_data.dart';
import 'package:flutter/material.dart';

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  int selectedAge = 20;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController =
        FixedExtentScrollController(initialItem: selectedAge - 1);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Сколько вам лет?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              'Это используется для получения персонализированных результатов и составления планов для вас',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey[800]),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 400,
                  width: 150,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: const Color.fromARGB(255, 242, 236, 255)),
                      color: const Color.fromARGB(255, 242, 236, 255),
                      borderRadius: BorderRadius.circular(50)),
                  child: ListWheelScrollView.useDelegate(
                    controller: _scrollController,
                    itemExtent: 60,
                    perspective: 0.002,
                    diameterRatio: 2,
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedAge = index + 1;
                      });
                    },
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Center(
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      childCount: 100,
                    ),
                  ),
                ),
                const Positioned(
                  top: 170,
                  left: 0,
                  right: 0,
                  child: Divider(
                    thickness: 2,
                    color: Color.fromARGB(255, 212, 189, 255),
                  ),
                ),
                const Positioned(
                  bottom: 170,
                  left: 0,
                  right: 0,
                  child: Divider(
                    thickness: 2,
                    color: Color.fromARGB(255, 212, 189, 255),
                  ),
                ),
              ],
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
                Navigator.popAndPushNamed(context, '/gender');
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
                  onPressed: () {
                    UserPreferences.saveUserAge(selectedAge);
                    Navigator.pushNamed(context, '/weight');
                  },
                  child: const Text(
                    'Продолжить',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
