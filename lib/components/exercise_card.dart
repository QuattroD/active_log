import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard(
      {super.key,
      required this.background,
      required this.title,
      required this.imageURL,
      required this.kcal,
      required this.time});

  final Color background;
  final String title;
  final String imageURL;
  final String kcal;
  final String time;
  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0.3,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: widget.background),
                color: widget.background,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          widget.title,
                          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(left: 20, top: 20),
                              child: Row(
                                children: [
                                  const Icon(Icons.timer_outlined, color: Color.fromARGB(255, 75, 75, 75),),
                                  Text(
                                    '${widget.time} мин',
                                    style: const TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 75, 75, 75)),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Row(
                                children: [
                                  const Icon(Icons.local_fire_department_outlined, color: Color.fromARGB(255, 75, 75, 75),),
                                  Text(
                                    '${widget.kcal} ккал',
                                    style: const TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 75, 75, 75)),
                                  ),
                                ],
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10), child: SizedBox(
                  width: 150,
                  child: Image(image: NetworkImage(widget.imageURL)),
                ),)
              ],
            )));

  }
}
