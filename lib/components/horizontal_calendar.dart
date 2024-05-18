import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalCalendar extends StatefulWidget {
  const HorizontalCalendar({super.key});

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            final currentDate = DateTime.now().add(Duration(days: index));
            final isSelected = currentDate.day == _selectedDate.day;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = currentDate;
                });
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                width: 50,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.deepPurple : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        DateFormat.E('ru').format(currentDate),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.white)),
                      child: Center(
                        child: Text(
                          DateFormat.d('ru').format(currentDate),
                          style: TextStyle(
                            color:
                                isSelected ? Colors.deepPurple : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              ),
            );
          },
        ),
      ),
    );
  }
}
