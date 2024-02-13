import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woodiary/constants/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:woodiary/screens/edit_profile_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  late String userEmail = '';
  late String userName = '';

  @override
  void initState() {
    super.initState();
    getDataForCurrentUser();
  }

  void getDataForCurrentUser() async {
    // 현재 사용자의 정보 가져오기
    User? user = _auth.currentUser;

    if (user != null) {
      String useremail = user.email!;

      // 해당 사용자의 문서에 대한 실시간 스트림 설정
      FirebaseFirestore.instance
          .collection('users')
          .doc(useremail)
          .snapshots()
          .listen((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          // 문서에서 데이터 가져오기
          Map<String, dynamic> userData =
              snapshot.data() as Map<String, dynamic>;

          // 가져온 데이터 사용하기
          userEmail = userData['email'];
          userName = userData['username'];

          // setState 호출하여 위젯에 데이터 변경을 알림
          setState(() {});
        } else {
          // print('사용자 문서가 존재하지 않습니다.');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void onLogout() async {
      // Show confirmation dialog
      bool logoutConfirmed = await showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('로그아웃'),
            content: const Text('로그아웃 하시겠습니까?'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancel logout
                },
                child: const Text(
                  '취소',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop(true); // Confirm logout
                },
                child: const Text(
                  '확인',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        },
      );

      // If user confirmed logout, sign out and update the UI
      if (logoutConfirmed == true) {
        await _auth.signOut();
        setState(() {});
      }
    }

    return Drawer(
      backgroundColor: const Color(0xffdeeac9),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage(
                'assets/image/0b2fd4801d03fde3a349ac1ffca4dc73.jpg',
              ),
            ),
            otherAccountsPictures: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        userName: userName,
                        userEmail: userEmail,
                      ), // 프로필 수정 페이지로 이동
                    ),
                  );
                },
                child: const FaIcon(
                  FontAwesomeIcons.pen,
                  size: Sizes.size16,
                  color: Color(0xff4e7055),
                ),
              ),
            ],
            accountName: Text(
              userName,
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
            accountEmail: Text(
              userEmail,
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
            arrowColor: Colors.green,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xff73a379),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(Icons.home),
              iconColor: Color(0xff73a379),
              focusColor: Color(0xff73a379),
              title: Text('홈'),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
          GestureDetector(
            onTap: onLogout,
            child: const ListTile(
              leading: Icon(Icons.logout),
              iconColor: Color(0xff73a379),
              focusColor: Color(0xff73a379),
              title: Text('로그아웃'),
            ),
          ),
        ],
      ),
    );
  }
}
