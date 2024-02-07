// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    super.initState();
    currentDate = widget.selectedDate;
  }

  @override
  void didUpdateWidget(covariant MonthCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentDate = widget.selectedDate;
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
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DayDetailsScreen(
                  year: year,
                  month: month,
                  day: daysList[index],
                  querySnapshot: widget.querySnapshot,
                ),
              ));
            },
            child: DayWidget(
              year: year,
              month: month,
              day: daysList[index],
              querySnapshot: widget.querySnapshot,
            ),
          );
        },
      ),
    );
  }
}

class DayWidget extends StatelessWidget {
  final int year;
  final int month;
  final int day;
  final QuerySnapshot<Map<String, dynamic>>? querySnapshot;

  const DayWidget({
    Key? key,
    required this.year,
    required this.month,
    required this.day,
    this.querySnapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy/MM/dd').format(DateTime(year, month, day));
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? documentList =
        querySnapshot?.docs.toList();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Text('Day $day'),
          if (documentList != null)
            ...documentList.map((doc) {
              var diaryDate = doc['date'];

              if (diaryDate is String) {
                var formattedDiaryDate = diaryDate;
                if (formattedDiaryDate == formattedDate) {
                  var diaryIcon = doc['icon'];

                  return Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        child: Column(
                          children: [
                            FaIcon(
                              diaryIcon == 'faceSmile'
                                  ? FontAwesomeIcons.faceSmile
                                  : diaryIcon == 'faceLaughSquint'
                                      ? FontAwesomeIcons.faceLaughSquint
                                      : diaryIcon == 'faceFrown'
                                          ? FontAwesomeIcons.faceFrown
                                          : diaryIcon == 'faceAngry'
                                              ? FontAwesomeIcons.faceAngry
                                              : diaryIcon == 'faceSadTear'
                                                  ? FontAwesomeIcons.faceSadTear
                                                  : null,
                              size: 36,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }
              return Container();
            }).toList(),
        ],
      ),
    );
  }
}

class DayDetailsScreen extends StatelessWidget {
  final int year;
  final int month;
  final int day;
  final QuerySnapshot<Map<String, dynamic>>? querySnapshot;

  const DayDetailsScreen({
    Key? key,
    required this.year,
    required this.month,
    required this.day,
    this.querySnapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy/MM/dd').format(DateTime(year, month, day));
    QueryDocumentSnapshot<Map<String, dynamic>>? diaryData;
    querySnapshot?.docs.forEach((doc) {
      if (doc['date'] == formattedDate) {
        diaryData = doc;
      }
    });
    var diaryIcon =
        diaryData?['icon'] as String? ?? 'face'; // 기본값으로 face 아이콘 설정

    return Scaffold(
      appBar: AppBar(
        title: Text('Day $day Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Details for Day $day'),
            FaIcon(
              diaryIcon == 'faceSmile'
                  ? FontAwesomeIcons.faceSmile
                  : diaryIcon == 'faceLaughSquint'
                      ? FontAwesomeIcons.faceLaughSquint
                      : diaryIcon == 'faceFrown'
                          ? FontAwesomeIcons.faceFrown
                          : diaryIcon == 'faceAngry'
                              ? FontAwesomeIcons.faceAngry
                              : diaryIcon == 'faceSadTear'
                                  ? FontAwesomeIcons.faceSadTear
                                  : null,
              size: 80,
            ),
          ],
        ),
      ),
    );
  }
}
