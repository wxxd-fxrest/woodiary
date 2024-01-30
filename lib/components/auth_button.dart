import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woodiary/constants/sizes.dart';
import 'package:woodiary/screens/auth/join_screen.dart';
import 'package:woodiary/screens/auth/login_screen.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final String authPage;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.authPage,
  });

  void _onGoTap(BuildContext context) {
    switch (authPage) {
      case 'signup':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const JoinScreen(),
          ),
        );
      case 'login':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onGoTap(context),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.all(
            Sizes.size20,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade500,
              width: Sizes.size1,
            ),
            borderRadius: BorderRadius.circular(
              Sizes.size8,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: icon,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
