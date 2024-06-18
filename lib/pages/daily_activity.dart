import 'package:active_log/components/card.dart';
import 'package:active_log/components/chart/chart_graph.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DailyActivityPage extends StatefulWidget {
  const DailyActivityPage({super.key});

  @override
  State<DailyActivityPage> createState() => _DailyActivityPageState();
}

class _DailyActivityPageState extends State<DailyActivityPage> {
  List<double> weeklySummary = [
    34.40,
    15.50,
    45.42,
    35.50,
    60.20,
    50.99,
    90.10
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(244, 244, 246, 250),
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Активность'),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  icon: const Icon(Icons.arrow_back)),
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.calendar_month))
              ],
            ),
            body: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Text(
                    'Добрый день, ${FirebaseAuth.instance.currentUser!.displayName.toString()}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: const Text(
                    'Следите за своей ежедневной активностью и оставайтесь здоровым',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5)),
                        GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(context, '/health');
                          },
                          child: InfoCard(
                            background: Colors.white,
                            textColor: Colors.black,
                            height: 0.12,
                            icon: Icons.brightness_3,
                            widget: Text('7.40 часов'),
                            title: 'Сон',
                            iconColor: Colors.orange,
                          ),
                        ),
                        const InfoCard(
                          background: Colors.white,
                          iconColor: Color.fromARGB(255, 136, 104, 190),
                          textColor: Colors.black,
                          height: 0.22,
                          icon: Icons.monitor_weight,
                          widget: Center(
                            child: Text('43,7'),
                          ),
                          title: 'ИМТ',
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5)),
                        InfoCard(
                            background: Colors.white,
                            iconColor: Colors.cyan,
                            textColor: Colors.black,
                            title: 'Упражнения',
                            height: 0.22,
                            icon: Icons.accessibility_new,
                            widget: Column(
                              children: [
                                Center(
                                  child: SizedBox(
                                    height: 80,
                                    child: MyChartGraph(
                                      weeklySumamry: weeklySummary,
                                    ),
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: '3',
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.cyan,
                                            fontWeight: FontWeight.bold),
                                        children: <TextSpan>[
                                      TextSpan(
                                          text: ' часа',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.normal))
                                    ]))
                              ],
                            )),
                      ],
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10)),
                    Column(
                      children: [
                        InfoCard(
                          background: Colors.white,
                          iconColor: Colors.blue,
                          textColor: Colors.black,
                          height: 0.22,
                          icon: Icons.water_drop,
                          widget: Center(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.grey[300],
                                  color: Colors.blue,
                                  value: 0.56,
                                  strokeCap: StrokeCap.round,
                                  strokeWidth: 9,
                                ),
                              ),
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: '100',
                                      style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '\nмл',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.normal))
                                      ]))
                            ],
                          )),
                          title: 'Вода',
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5)),
                        InfoCard(
                          background: Colors.white,
                          iconColor: Colors.green,
                          textColor: Colors.black,
                          height: 0.22,
                          icon: Icons.restaurant_menu,
                          widget: Center(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.grey[300],
                                  color: Colors.green,
                                  value: 0.56,
                                  strokeCap: StrokeCap.round,
                                  strokeWidth: 9,
                                ),
                              ),
                              RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: '245',
                                      style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '\nкалорий',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.normal))
                                      ]))
                            ],
                          )),
                          title: 'Калории',
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )));
  }
}
