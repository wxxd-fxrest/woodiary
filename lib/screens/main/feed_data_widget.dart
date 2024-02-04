import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woodiary/constants/gaps.dart';

class FeedDataWidget extends StatelessWidget {
  const FeedDataWidget({
    super.key,
    required this.querySnapshot,
  });

  final QuerySnapshot<Map<String, dynamic>>? querySnapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: querySnapshot!.docs.map((doc) {
        var diaryDate = doc['date'];
        var diaryText = doc['text'];
        var diaryIcon = doc['icon'];

        return Column(
          children: [
            Gaps.v10,
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade200,
              ),
              child: Column(
                children: [
                  Text('date: $diaryDate'),
                  Text('text: $diaryText'),
                  // Text('icon: $diaryIcon'),

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
                  ),
                  // 필요한 데이터에 따라 추가적인 Text 위젯들을 만들어 출력할 수 있습니다.
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:woodiary/screens/main/grid_view_widget.dart';

// class FeedDataWidget extends StatelessWidget {
//   const FeedDataWidget({
//     Key? key,
//     required this.querySnapshot,
//   }) : super(key: key);

//   final QuerySnapshot<Map<String, dynamic>>? querySnapshot;

//   @override
//   Widget build(BuildContext context) {
//     if (querySnapshot == null || querySnapshot!.docs.isEmpty) {
//       return const Center(child: Text('No data available.'));
//     }

//     // 날짜를 기준으로 그룹화
//     Map<String, List<Map<String, dynamic>>> groupedData = {};
//     for (QueryDocumentSnapshot<Map<String, dynamic>> doc
//         in querySnapshot!.docs) {
//       var diaryDate = doc['date'];
//       var diaryText = doc['text'];
//       var diaryIcon = doc['icon'];

//       if (!groupedData.containsKey(diaryDate)) {
//         groupedData[diaryDate] = [];
//       }

//       groupedData[diaryDate]!.add({'text': diaryText, 'icon': diaryIcon});
//     }

//     // 그룹화된 데이터로 그리드 빌더 생성
//     return GridViewWidget(groupedData: groupedData);
//   }
// }
