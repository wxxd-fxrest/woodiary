// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woodiary/screens/main/day_detail_widget.dart';
import 'package:woodiary/screens/main/day_widget.dart';

class MonthCalendarWidget extends StatefulWidget {
  const MonthCalendarWidget({
    Key? key,
    required this.selectedDate,
    this.querySnapshot,
  }) : super(key: key);

  final QuerySnapshot<Map<String, dynamic>>? querySnapshot;
  final DateTime selectedDate;

  @override
  _MonthCalendarWidgetState createState() => _MonthCalendarWidgetState();
}

class _MonthCalendarWidgetState extends State<MonthCalendarWidget> {
  late DateTime currentDate;
  late QuerySnapshot<Map<String, dynamic>>? _currentQuerySnapshot;

  @override
  void initState() {
    super.initState();
    currentDate = widget.selectedDate;
    _currentQuerySnapshot = widget.querySnapshot;
  }

  @override
  void didUpdateWidget(MonthCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.querySnapshot != _currentQuerySnapshot) {
      setState(() {
        _currentQuerySnapshot = widget.querySnapshot;
      });
    }
  }

  int getDaysInMonth(DateTime date) {
    DateTime firstDayOfNextMonth = DateTime(date.year, date.month + 1, 1);
    DateTime lastDayOfThisMonth =
        firstDayOfNextMonth.subtract(const Duration(days: 1));

    return lastDayOfThisMonth.day;
  }

  @override
  Widget build(BuildContext context) {
    int daysInMonth = getDaysInMonth(currentDate);
    List<int> daysList = List.generate(daysInMonth, (index) => index + 1);
    int year = currentDate.year;
    int month = currentDate.month;

    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: daysInMonth,
        itemBuilder: (context, index) {
          bool hasData = false;
          if (_currentQuerySnapshot != null) {
            String formattedDate = DateFormat('yyyy/MM/dd')
                .format(DateTime(year, month, daysList[index]));
            hasData = _currentQuerySnapshot!.docs
                .any((doc) => doc['date'] == formattedDate);
          }

          return GestureDetector(
            key: UniqueKey(),
            onTap: hasData
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DayDetailsScreen(
                        year: year,
                        month: month,
                        day: daysList[index],
                        querySnapshot: _currentQuerySnapshot,
                      ),
                    ));
                  }
                : null,
            child: DayWidget(
              year: year,
              month: month,
              day: daysList[index],
              querySnapshot: _currentQuerySnapshot,
            ),
          );
        },
      ),
    );
  }
}
