import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woodiary/constants/gaps.dart';
import 'package:woodiary/constants/sizes.dart';
import 'package:intl/intl.dart';

class NewPostScreen extends StatefulWidget {
  final String emotion;

  static const Map<String, IconData> emotionIcons = {
    'faceSmile': FontAwesomeIcons.faceSmile,
    'faceLaughSquint': FontAwesomeIcons.faceLaughSquint,
    'faceFrown': FontAwesomeIcons.faceFrown,
    'faceAngry': FontAwesomeIcons.faceAngry,
    'faceSadTear': FontAwesomeIcons.faceSadTear,
    // 추가적인 감정 및 아이콘 정의
  };

  const NewPostScreen({super.key, required this.emotion});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final TextEditingController _diaryTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    IconData selectedIcon =
        NewPostScreen.emotionIcons[widget.emotion] ?? FontAwesomeIcons.question;

    String formattedDate = DateFormat('yyy/MM/dd')
        .format(DateTime.now()); // 오늘 날짜를 "년/월/일" 형식으로 포맷팅

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(formattedDate),
        leading: IconButton(
          icon: const Icon(Icons.close), // 엑스 아이콘 사용
          onPressed: () {
            Navigator.pop(context); // 창 닫기
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check), // 오른쪽에 추가할 아이콘
            onPressed: () {
              // 아이콘을 눌렀을 때 수행할 동작
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gaps.v20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  selectedIcon,
                  size: Sizes.size64,
                ),
              ],
            ),
            Gaps.v20,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
              ),
              child: TextField(
                controller: _diaryTextController,
                maxLines: null, // null로 설정하면 자동으로 다중 행이 됨
                decoration: InputDecoration(
                  hintText: '무슨 일이 있었나요?',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
