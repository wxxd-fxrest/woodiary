import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:woodiary/constants/gaps.dart';
import 'package:woodiary/constants/sizes.dart';

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
        title: Text(
          '$year년 $month월 $day일',
          style: const TextStyle(
            color: Color(0xff73a379),
            fontSize: Sizes.size16 + Sizes.size2,
          ),
        ),
        leading: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.angleLeft,
            color: Color(0xff73a379),
            size: Sizes.size28,
          ),
          onPressed: () {
            Navigator.pop(context); // 이전 화면으로 이동
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Color(0xff73a379),
              size: Sizes.size28,
            ),
            onPressed: () {
              // 버튼을 눌렀을 때 수행할 작업 추가
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gaps.v28,
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
                size: 100,
                color: const Color(0xff73a379),
              ),
              Gaps.v20,
              if (diaryData != null) // diaryData가 null이 아닌 경우에만 추가 데이터 표시
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Sizes.size24),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 21),
                                child: const FaIcon(
                                  FontAwesomeIcons.star,
                                  color: Color.fromARGB(255, 83, 118, 87),
                                  size: Sizes.size16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                child: const Text(
                                  '오늘의 일기',
                                  style: TextStyle(
                                    fontSize: Sizes.size16 + Sizes.size4,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 83, 118, 87),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 21),
                                child: const FaIcon(
                                  FontAwesomeIcons.star,
                                  color: Color.fromARGB(255, 83, 118, 87),
                                  size: Sizes.size16,
                                ),
                              ),
                            ],
                          ),
                          Gaps.v14,
                          Text(
                            '${diaryData?.get('text')}',
                            style: TextStyle(
                              fontSize: Sizes.size16 + Sizes.size2,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // diaryData에서 필요한 필드를 가져와서 표시
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
