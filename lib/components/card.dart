import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({super.key, background, element, iconCard, name});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  late String name;
  late Color background;
  Widget? element;
  late IconData iconCard;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          decoration: BoxDecoration(border: Border.all(width: 1, color: background)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(name), Icon(iconCard)],
          )
        ],
      ),
    ));
  }
}
