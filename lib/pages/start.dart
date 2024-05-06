import 'package:active_log/components/card.dart';
import 'package:active_log/components/chart_graph.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  List<double> weeklySummary = [
    4.40,
    2.50,
    42.42,
    10.50,
    100.20,
    88.99,
    90.10
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(244, 244, 246, 250),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Активность'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_month))
          ],
        ),
        body: SafeArea(
            child: Column(
          children: [
            const Text('Добрый день, Эльмир'),
            const Text(
                'Следите за своей ежедневной активностью и оставайтесь здоровыми'),
            Wrap(
              children: [
                const InfoCard(
                  background: Color.fromARGB(255, 114, 101, 227),
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  height: 0.22,
                  icon: Icons.directions_run,
                  widget: Center(
                      child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          backgroundColor: Color.fromARGB(255, 136, 104, 190),
                          color: Colors.white,
                          value: 0.56,
                          strokeCap: StrokeCap.round,
                          strokeWidth: 7,
                        ),
                      ),
                      Text(
                        '7,333\nшаги',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  )),
                  title: 'Ходьба',
                ),
                const InfoCard(
                  background: Colors.white,
                  textColor: Colors.black,
                  height: 0.15,
                  icon: Icons.brightness_2,
                  widget: Text('7.40 часов'),
                  title: 'Сон',
                  iconColor: Colors.yellow,
                ),
                InfoCard(
                  background: Colors.white,
                  iconColor: Colors.cyan,
                  textColor: Colors.black,
                  height: 0.22,
                  icon: Icons.accessibility_new,
                  widget: Center(child: SizedBox(
                    height: 70,
                    child: MyChartGraph(weeklySumamry: weeklySummary,),
                  ),),
                  title: 'Упражнения',
                ),
              ],
            ),
          ],
        )));
  }
}
