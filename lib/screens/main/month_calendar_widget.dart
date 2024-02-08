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

    // querySnapshot이 없거나 documentList가 비어있으면 빈 컨테이너를 반환하여 렌더링을 피합니다.
    if (querySnapshot == null || documentList == null || documentList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Text('Day $day'),
          for (var doc in documentList) ...[
            if (doc['date'] == formattedDate)
              Container(
                decoration: const BoxDecoration(),
                child: FaIcon(
                  _getDiaryIcon(doc['icon'] as String? ?? ''),
                  size: 36,
                ),
              ),
          ],
        ],
      ),
    );
  }

  // 일기 아이콘을 반환하는 함수
  IconData _getDiaryIcon(String icon) {
    switch (icon) {
      case 'faceSmile':
        return FontAwesomeIcons.faceSmile;
      case 'faceLaughSquint':
        return FontAwesomeIcons.faceLaughSquint;
      case 'faceFrown':
        return FontAwesomeIcons.faceFrown;
      case 'faceAngry':
        return FontAwesomeIcons.faceAngry;
      case 'faceSadTear':
        return FontAwesomeIcons.faceSadTear;
      default:
        return FontAwesomeIcons.question; // 기본값으로 question 아이콘 사용
    }
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
