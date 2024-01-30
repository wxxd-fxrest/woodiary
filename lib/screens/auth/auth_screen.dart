import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woodiary/components/auth_button.dart';
import 'package:woodiary/constants/gaps.dart';
import 'package:woodiary/constants/sizes.dart';
import 'package:woodiary/screens/auth/login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                'WooDiary',
                style: TextStyle(
                  fontSize: Sizes.size36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v10,
              Text(
                '오늘 하루 일과를 기록하고 추억해 보세요.',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.black45,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              AuthButton(
                authPage: 'signup',
                text: 'Use email & password',
                icon: FaIcon(
                  FontAwesomeIcons.user,
                ),
              ),
              Gaps.v16,
              AuthButton(
                authPage: 'signup',
                text: 'Continue with Google',
                icon: FaIcon(
                  FontAwesomeIcons.google,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account?',
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.h6,
              GestureDetector(
                onTap: () => _onLoginTap(context),
                child: Text(
                  'Log in',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Sizes.size16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
