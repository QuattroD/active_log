import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  const InfoCard(
      {super.key,
      required this.background,
      required this.icon,
      required this.widget,
      required this.title,
      required this.iconColor,
      required this.textColor,
      required this.height});
  final Color background;
  final IconData icon;
  final Widget widget;
  final String title;
  final Color iconColor;
  final Color textColor;
  final double height;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0.3,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * widget.height,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: widget.background),
              color: widget.background,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(color: widget.textColor, fontSize: 20),
                  ),
                  Icon(
                    widget.icon,
                    color: widget.iconColor,
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              widget.widget
            ],
          ),
        ));
  }
}
