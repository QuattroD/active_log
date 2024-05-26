import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body:  Center(
        child: Column(
          children: [
            const Image(
              image: AssetImage('images/welcomebg.png'),
              width: double.infinity,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/activelog.png'),
                  width: 70,
                ),
                Text(
                  'ActiveLog',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            const SizedBox(
              child: Text('Вы готовы начать!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            SizedBox(
              width: 350,
              child: Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                  'Следите за прогрессом, планируйте питание и получайте мотивацию. Начните свое путешествие к здоровому образу жизни сегодня!'),
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
            const SizedBox(width: 100,),
            Container(
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(15)),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/gender');
                  },
                  child: const Text(
                    'Начнем',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
