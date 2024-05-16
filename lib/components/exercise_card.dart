import 'package:flutter/material.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard(
      {super.key, required this.background, required this.title});

  final Color background;
  final String title;
  //final Image image;
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
            child:  Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.title,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      const Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '15 мин',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              '345 ккал',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 150,
                  child: Image(image: AssetImage('images/yoga.png')),
                )
              ],
            )));
  }
}
