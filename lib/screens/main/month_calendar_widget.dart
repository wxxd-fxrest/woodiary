// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MonthCalendarWidget extends StatefulWidget {
  const MonthCalendarWidget(
      {super.key, required this.selectedDate, this.querySnapshot});

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
    // print('Query Snapshot: ${widget.querySnapshot}');
  }

  @override
  void didUpdateWidget(covariant MonthCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentDate = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: getDaysInMonth(currentDate),
        itemBuilder: (context, index) {
          return DayWidget(
            day: index + 1,
            querySnapshot: widget.querySnapshot,
          );
        },
      ),
    );
  }

  int getDaysInMonth(DateTime date) {
    DateTime firstDayOfNextMonth = DateTime(date.year, date.month + 1, 1);
    DateTime lastDayOfThisMonth =
        firstDayOfNextMonth.subtract(const Duration(days: 1));
    return lastDayOfThisMonth.day;
  }

  void updateCalendar(DateTime newDate) {
    setState(() {
      currentDate = newDate;
    });
  }
}

class DayWidget extends StatelessWidget {
  final int day;
  final QuerySnapshot<Map<String, dynamic>>? querySnapshot;

  const DayWidget({Key? key, required this.day, this.querySnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 현재 맵핑되는 날짜
    String currentMappedDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

    // querySnapshot을 List로 변환
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

              // 여기서 날짜 데이터의 타입이 String이 아닌 경우에 대한 처리를 해줍니다.
              if (diaryDate is String) {
                // String 타입인 경우 직접 사용
                var formattedDiaryDate = diaryDate;

                if (formattedDiaryDate == currentMappedDate) {
                  var diaryText = doc['text'];
                  var diaryIcon = doc['icon'];

                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade200,
                        ),
                        child: Column(
                          children: [
                            Text('date: $formattedDiaryDate'),
                            Text('text: $diaryText'),
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

              // 기본적으로 빈 Container를 반환
              return Container();
            }).toList(),
        ],
      ),
    );
  }
}

// 현재 currentMappedDate이 금일날짜만 가져옴
// 각 일수에 맞는 데이터 바인딩 해야 함 