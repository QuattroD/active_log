import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HorizontalCalendar extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;

  const HorizontalCalendar({Key? key, required this.onDateSelected})
      : super(key: key);

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  DateTime _selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentDate();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentDate() {
    final DateTime today = DateTime.now();
    final DateTime firstDayOfCurrentMonth =
        DateTime(today.year, today.month, 1);
    final DateTime firstDayOfPreviousMonth =
        DateTime(today.year, today.month - 1, 1);
    final int daysInPreviousMonth = DateTime(today.year, today.month, 0).day;
    final List<DateTime> dates = List.generate(
      daysInPreviousMonth + DateTime(today.year, today.month + 1, 0).day,
      (index) {
        return index < daysInPreviousMonth
            ? firstDayOfPreviousMonth.add(Duration(days: index))
            : firstDayOfCurrentMonth
                .add(Duration(days: index - daysInPreviousMonth));
      },
    );

    int todayIndex = dates.indexWhere((date) =>
        date.day == today.day &&
        date.month == today.month &&
        date.year == today.year);

    if (todayIndex != -1) {
      _scrollController.animateTo(
        todayIndex * 60.0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final DateTime firstDayOfCurrentMonth =
        DateTime(today.year, today.month, 1);
    final DateTime firstDayOfPreviousMonth =
        DateTime(today.year, today.month - 1, 1);
    final int daysInPreviousMonth = DateTime(today.year, today.month, 0).day;
    final List<DateTime> dates = List.generate(
      daysInPreviousMonth + DateTime(today.year, today.month + 1, 0).day,
      (index) {
        return index < daysInPreviousMonth
            ? firstDayOfPreviousMonth.add(Duration(days: index))
            : firstDayOfCurrentMonth
                .add(Duration(days: index - daysInPreviousMonth));
      },
    );
    return Center(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: dates.length,
          itemBuilder: (BuildContext context, int index) {
            final DateTime currentDate = dates[index];
            final bool isSelected = currentDate.day == _selectedDate.day &&
                currentDate.month == _selectedDate.month &&
                currentDate.year == _selectedDate.year;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = currentDate;
                  widget.onDateSelected(_selectedDate);
                });
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                width: 50,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.deepPurple : Colors.transparent,
                  border: Border.all(
                    width: 1,
                    color: isSelected
                        ? Colors.deepPurple
                        : const Color.fromARGB(255, 224, 224, 224),
                  ),
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
                            color: isSelected
                                ? Colors.white
                                : const Color.fromARGB(255, 143, 143, 143),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.white),
                        ),
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
