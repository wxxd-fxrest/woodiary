// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woodiary/constants/gaps.dart';
import 'package:woodiary/constants/sizes.dart';
import 'package:woodiary/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // text 컨트롤러

  bool _loginError = false;
  bool _passwordEye = true;
  // 변수 생성

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
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          );
        } on FirebaseAuthException catch (e) {
          print('An error occurred during login: $e');
          setState(() {
            _loginError = true;
          });
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
            '로그인',
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
                  '로그인을 진행해 주세요.',
                  style: TextStyle(
                    fontSize: Sizes.size24 - Sizes.size2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v32,
                Column(
                  children: [
                    TextFormField(
                      onTap: () {
                        if (_loginError) {
                          setState(() {
                            _loginError = false;
                          });
                        }
                      },
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
                      onTap: () {
                        if (_loginError) {
                          setState(() {
                            _loginError = false;
                          });
                        }
                      },
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
                    Gaps.v10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (_loginError)
                          const Text(
                            '로그인에 실패했습니다. 다시 한 번 확인해 주세요.',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: Sizes.size12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    )
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
                  '로그인',
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
