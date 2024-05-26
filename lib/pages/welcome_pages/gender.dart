import 'package:active_log/services/user_data.dart';
import 'package:flutter/material.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  bool isMale = false;
  bool isFemale = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 60)),
            const Image(
              image: AssetImage('images/activelog.png'),
              width: 150,
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
            const Text(
              'Выберите пол',
              style: TextStyle(fontSize: 35),
            ),
            Text(
              'Чтобы предоставить вам лучший опыт, нам необходимо знать ваш пол',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey[800]),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                      isFemale = false;
                    });
                  },
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                        color: isMale ? Colors.deepPurple : const Color.fromARGB(255, 242, 236, 255),
                        border: Border.all(width: 1, color: const Color.fromARGB(255, 242, 236, 255)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: SizedBox(
                              width: 130,
                              height: 130,
                              child: Image.asset('images/male.png'),
                            ),
                          ),
                          Text(
                            'Мужской',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: isMale ? Colors.white : Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                      isFemale = true;
                    });
                  },
                  child: Container(
                    width: 170,
                    height: 170,
                    decoration: BoxDecoration(
                        color: isFemale ? Colors.deepPurple : const Color.fromARGB(255, 242, 236, 255),
                        border: Border.all(width: 1, color: const Color.fromARGB(255, 242, 236, 255)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: SizedBox(
                              width: 130,
                              height: 130,
                              child: Image.asset('images/female.png'),
                            ),
                          ),
                          Text(
                            'Женский',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold, color: isFemale ? Colors.white : Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
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
                Navigator.popAndPushNamed(context, '/welcome');
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
                    if(isMale == true)
                    {
                      UserPreferences.saveUserGender('Мужской');
                      Navigator.pushNamed(context, '/age');
                    }
                    else if (isFemale == true)
                    {
                      UserPreferences.saveUserGender('Женский');
                      Navigator.pushNamed(context, '/age');
                    }
                    else if (isMale == false && isFemale == false)
                    {
                    }
                    
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
