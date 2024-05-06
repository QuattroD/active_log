import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InfoCard extends StatefulWidget {
  const InfoCard(
      {super.key,
      required this.background,
      required this.icon,
      required this.widget,
      required this.title});
  final Color background;
  final IconData icon;
  final Widget widget;
  final String title;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: widget.background),
          color: widget.background,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.title,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Icon(
                widget.icon,
                color: Colors.white,
              )
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          widget.widget
        ],
      ),
    ));
  }
}
