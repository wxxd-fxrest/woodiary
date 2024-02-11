import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:woodiary/constants/gaps.dart';

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
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          // color: Colors.amber,
          ),
      child: Column(
        children: [
          Text(
            'Day $day',
          ),
          Gaps.v12,
          for (var doc in documentList) ...[
            if (doc['date'] == formattedDate)
              Container(
                decoration: const BoxDecoration(),
                child: FaIcon(
                  _getDiaryIcon(doc['icon'] as String? ?? ''),
                  size: 34,
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
