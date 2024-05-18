import 'package:active_log/components/horizontal_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 251),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ежедневный рацион'),
        leading: const SizedBox(),
        toolbarHeight: 80,
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
                  const HorizontalCalendar(),
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
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
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
                        border: Border.all(width: 1, color: Colors.white)),
                    child: const Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 20, top: 20),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    value: 0.65,
                                    strokeWidth: 5,
                                    color: Colors.cyan,
                                    backgroundColor: Color.fromARGB(255, 211, 211, 211),
                                  ),
                                ))
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 22),
                              child: SizedBox(
                                child: Text('Калории'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20,),
                              child: SizedBox(
                                child: Text('856 кКал'),
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
                        border: Border.all(width: 1, color: Colors.white)),
                    child:  Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 20, top: 20),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    value: 0.15,
                                    strokeWidth: 5,
                                    color: Colors.orange,
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ))
                          ],
                        ),
                        const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 22),
                              child: SizedBox(
                                child: Text('Калории'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20,),
                              child: SizedBox(
                                child: Text('856 кКал'),
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
                        border: Border.all(width: 1, color: Colors.white)),
                    child:  Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 20, top: 20),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    value: 0.3,
                                    strokeWidth: 5,
                                    color: Colors.amber,
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ))
                          ],
                        ),
                        const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20,top: 22),
                              child: SizedBox(
                                child: Text('Калории'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20,),
                              child: SizedBox(
                                child: Text('856 кКал'),
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
                        border: Border.all(width: 1, color: Colors.white)),
                    child:  Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 20, top: 20),
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    value: 0.9,
                                    strokeWidth: 5,
                                    color: Colors.deepPurple,
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ))
                          ],
                        ),
                        const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20,top: 22),
                              child: SizedBox(
                                child: Text('Калории'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20,),
                              child: SizedBox(
                                child: Text('856 кКал'),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Container(
            width: MediaQuery.of(context).size.width * 0.89,
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(15)),
            child: TextButton(
                onPressed: () {},
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
