import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

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
            if (diaryData != null) // diaryData가 null이 아닌 경우에만 추가 데이터 표시
              Column(
                children: [
                  const Text('Additional Data:'),
                  Text('Title: ${diaryData?.get('text')}'),
                  // diaryData에서 필요한 필드를 가져와서 표시
                ],
              ),
          ],
        ),
      ),
    );
  }
}
