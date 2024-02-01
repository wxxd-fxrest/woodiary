import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:woodiary/components/drawer_widget.dart';
import 'package:woodiary/constants/gaps.dart';
import 'package:woodiary/constants/sizes.dart';
import 'package:woodiary/screens/new_post_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final firestore = FirebaseFirestore.instance;

  bool _open = false;

  void _onFaceIconTap(String emotion) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewPostScreen(emotion: emotion),
      ),
    );
    _onScaffoldTap();
  }

  void _onClickOpenWrite() {
    _open = !_open;
    setState(() {});
  }

  void _onScaffoldTap() {
    if (_open == true) {
      _open = false;
    }
    setState(() {});
  }

  String formattedYear =
      DateFormat('yyy').format(DateTime.now()); // 오늘 날짜를 "년/월/일" 형식으로 포맷팅
  String formattedMonth =
      DateFormat('MM').format(DateTime.now()); // 오늘 날짜를 "년/월/일" 형식으로 포맷팅

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        backgroundColor: _open == false ? Colors.white : Colors.grey.shade300,
        drawer: const DrawerWidget(),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(Sizes.size20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.indent,
                            color: Color(0xff73a379),
                          ),
                        );
                      },
                    ),
                    const FaIcon(
                      FontAwesomeIcons.house,
                      color: Color(0xff73a379),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Gaps.v10,
                    Text(
                      '$formattedYear년',
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                      ),
                    ),
                    Text(
                      '$formattedMonth월',
                      style: const TextStyle(
                        fontSize: Sizes.size24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // StreamBuilder 추가
              StreamBuilder(
                stream: firestore.collection('posts').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();
                    default:
                      var querySnapshot = snapshot.data;
                      if (querySnapshot == null || querySnapshot.docs.isEmpty) {
                        return const Text('No documents in the collection');
                      }

                      // 컬렉션의 모든 문서에 대한 정보를 사용하여 렌더링
                      return Column(
                        children: querySnapshot.docs.map((doc) {
                          var diaryDate = doc['date'];
                          var diaryText = doc['text'];
                          var diaryIcon = doc['icon'];

                          return Column(
                            children: [
                              Text('date: $diaryDate'),
                              Text('text: $diaryText'),
                              Text('icon: $diaryIcon'),

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
                                                    ? FontAwesomeIcons
                                                        .faceSadTear
                                                    : null,
                              )
                              // 필요한 데이터에 따라 추가적인 Text 위젯들을 만들어 출력할 수 있습니다.
                            ],
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: Sizes.size64 + Sizes.size64,
                    ),
                    width: 100,
                    height: 220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: _onClickOpenWrite,
                              child: const FaIcon(
                                FontAwesomeIcons.circlePlus,
                                size: Sizes.size20 + Sizes.size28,
                                color: Color(0xff73a379),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_open)
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.all(
                        Sizes.size16,
                      ),
                      width: 340,
                      height: 114,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Sizes.size12,
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '오늘 하루는 어땠어요?',
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Gaps.v10,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => _onFaceIconTap('faceSmile'),
                                  child: const FaIcon(
                                    FontAwesomeIcons.faceSmile,
                                    size: Sizes.size36,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      _onFaceIconTap('faceLaughSquint'),
                                  child: const FaIcon(
                                    FontAwesomeIcons.faceLaughSquint,
                                    size: Sizes.size36,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _onFaceIconTap('faceFrown'),
                                  child: const FaIcon(
                                    FontAwesomeIcons.faceFrown,
                                    size: Sizes.size36,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _onFaceIconTap('faceAngry'),
                                  child: const FaIcon(
                                    FontAwesomeIcons.faceAngry,
                                    size: Sizes.size36,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _onFaceIconTap('faceSadTear'),
                                  child: const FaIcon(
                                    FontAwesomeIcons.faceSadTear,
                                    size: Sizes.size36,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
