// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woodiary/constants/gaps.dart';
import 'package:woodiary/constants/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:woodiary/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // text 컨트롤러
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _passwordEye = true;
  // 변수 생성

  // 앱 충돌을 예방하기 위해 _emailController 제거

  void _onClearEmail() {
    _emailController.clear();
  }

  void _onClearPassword() {
    _passwordController.clear();
  }

  void _onToggleEye() {
    _passwordEye = !_passwordEye;
    setState(() {});
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
    // input 외 영역 클릭 시 키보드 없애기
  }

  Map<String, String> formData = {};

  void _onJoinNextTap() async {
    // 비동기적인 부분에 들어가기 전에 BuildContext를 변수에 저장합니다.
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        try {
          // FirebaseAuth에서 사용자 생성 시도
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text,
          );

          // 성공적으로 생성된 경우 Firestore에 데이터 추가 및 화면 이동
          await _firestore.collection('users').doc(_emailController.text).set({
            'email': _emailController.text,
            'username': _emailController.text.split('@').first
          });

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          );
        } on FirebaseAuthException catch (e) {
          // FirebaseAuthException 예외 처리
          if (e.code == 'invalid-email') {
            // 사용자에게 이메일 주소 형식이 잘못되었음을 알림
            print('The email address is badly formatted.');
          } else {
            // 다른 FirebaseAuthException에 대한 예외 처리
            print('Error during registration: $e');
          }
        } catch (e) {
          // 다른 예외에 대한 예외 처리
          print('Error during registration: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '회원가입',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v40,
                const Text(
                  '가입을 진행해 주세요.',
                  style: TextStyle(
                    fontSize: Sizes.size24 - Sizes.size2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v32,
                Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: 'Email',
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
                        if (value == null || value.isEmpty) {
                          return 'Email을 입력해 주세요.';
                        }
                        final regExp = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if (!regExp.hasMatch(value)) {
                          return '올바른 이메일 형식이 아닙니다.';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          formData['email'] = newValue;
                        }
                      },
                    ),
                    Gaps.v20,
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _passwordEye,
                      decoration: InputDecoration(
                        hintText: 'Password',
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
                              onTap: _onClearPassword,
                              child: FaIcon(
                                FontAwesomeIcons.solidCircleXmark,
                                color: Colors.grey.shade500,
                                size: Sizes.size20 + Sizes.size2,
                              ),
                            ),
                            Gaps.h10,
                            GestureDetector(
                              onTap: _onToggleEye,
                              child: FaIcon(
                                _passwordEye
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                color: Colors.grey.shade500,
                                size: Sizes.size20 + Sizes.size2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      cursorColor: Theme.of(context).primaryColor,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '비밀번호를 입력해 주세요.';
                        }
                        if (value.length < 8 || value.length > 20) {
                          return '비밀번호는 8자 이상, 20자 이하이어야 합니다.';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        if (newValue != null) {
                          formData['password'] = newValue;
                        }
                      },
                    ),
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
            onTap: _onJoinNextTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Sizes.size8,
                ),
                color: const Color(0xff73a379),
              ),
              child: const Center(
                child: Text(
                  '회원가입',
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
