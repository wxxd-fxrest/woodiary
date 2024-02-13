import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woodiary/constants/gaps.dart';
import 'package:woodiary/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  final String userName;
  final String userEmail;

  const EditProfileScreen(
      {Key? key, required this.userName, required this.userEmail})
      : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
    // input 외 영역 클릭 시 키보드 없애기
  }

  void _onClearEmail() {
    _nameController.clear();
  }

  void _onUpdateProfile() {
    // Firestore 컬렉션 레퍼런스 설정
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // 수정할 데이터
    Map<String, dynamic> updatedData = {
      'username': _nameController.text, // 사용자명 수정
      // 추가적인 필드도 필요하다면 여기에 추가
    };

    // 해당 사용자의 데이터 업데이트
    users
        .doc(widget.userEmail) // 사용자의 문서에 접근
        .update(updatedData) // 데이터 업데이트
        .then((value) {
      // 업데이트 성공
      // print("사용자 데이터 업데이트 완료");
    }).catchError((error) {
      // 업데이트 실패
      // print("사용자 데이터 업데이트 실패: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '프로필 수정',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/image/0b2fd4801d03fde3a349ac1ffca4dc73.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Gaps.v44,
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: widget.userName,
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        suffix: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: _onClearEmail,
                              child: FaIcon(
                                FontAwesomeIcons.solidCircleXmark,
                                color: Colors.grey.shade500,
                                size: Sizes.size20 + Sizes.size2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      cursorColor: Theme.of(context).primaryColor,
                      validator: (value) {
                        return null;
                      },
                    ),
                    Gaps.v20,
                  ],
                ),
                Gaps.v32,
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          child: GestureDetector(
            onTap: _onUpdateProfile,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Sizes.size8,
                ),
                color: const Color(0xff73a379),
              ),
              child: const Center(
                child: Text(
                  '수정하기',
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
