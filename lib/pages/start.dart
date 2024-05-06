import 'package:active_log/components/card.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Активность'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_month))
        ],
      ),
      body: const Wrap(
        children: [
          InfoCard(
            background: Color.fromARGB(255, 114, 101, 227),
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
                  '7,333',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                )
              ],
            )),
            title: 'Шаги',
          )
        ],
      ),
    );
  }
}
