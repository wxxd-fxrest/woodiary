import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required this.groupedData,
  });

  final Map<String, List<Map<String, dynamic>>> groupedData;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = (screenWidth / 100).floor(); // 각 그리드의 최소 가로폭을 50으로 가정

    return Container(
      decoration: const BoxDecoration(
        color: Colors.amberAccent,
      ),
      height: 600,
      width: 500,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 4.0, // 그리드 아이템 간의 간격
          crossAxisSpacing: 4.0, // 그리드 아이템 간의 간격
        ),
        itemCount: groupedData.length,
        itemBuilder: (context, index) {
          var date = groupedData.keys.elementAt(index);
          var diaries = groupedData[date]!;

          return Container(
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            child: Column(
              children: [
                Text('Date: $date'),
                for (var diary in diaries)
                  Row(
                    children: [
                      FaIcon(
                        diary['icon'] == 'faceSmile'
                            ? FontAwesomeIcons.faceSmile
                            : diary['icon'] == 'faceLaughSquint'
                                ? FontAwesomeIcons.faceLaughSquint
                                : diary['icon'] == 'faceFrown'
                                    ? FontAwesomeIcons.faceFrown
                                    : diary['icon'] == 'faceAngry'
                                        ? FontAwesomeIcons.faceAngry
                                        : diary['icon'] == 'faceSadTear'
                                            ? FontAwesomeIcons.faceSadTear
                                            : null,
                      ),
                      Text(' ${diary['text']}'),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
