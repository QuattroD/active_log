import 'package:active_log/components/card.dart';
import 'package:active_log/components/chart/chart_graph.dart';
import 'package:active_log/pages/googlefit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DailyActivityPage extends StatefulWidget {
  const DailyActivityPage({super.key});

  @override
  State<DailyActivityPage> createState() => _DailyActivityPageState();
}

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTHORIZED,
  AUTH_NOT_GRANTED,
  STEPS_READY,
  HEALTH_CONNECT_STATUS,
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

  void initState() {
    
    super.initState();
  }

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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HealthApp(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.calendar_month))
              ],
            ),
            body: Column(
              children: [
                const Padding(padding: EdgeInsetsDirectional.symmetric(vertical: 10)),
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
                          iconColor: Colors.red,
                          textColor: Colors.black,
                          height: 0.22,
<<<<<<< HEAD
                          icon: Icons.local_fire_department,
=======
                          icon: Icons.restaurant_menu,
>>>>>>> 225e4d7bf36d205ff9c6fb6455f80f416c375b48
                          widget: Center(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.grey[300],
                                  color: Colors.red,
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
