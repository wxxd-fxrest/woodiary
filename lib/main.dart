import 'package:flutter/material.dart';
import 'package:woodiary/constants/sizes.dart';
import 'package:woodiary/screens/main_screen.dart';

void main() {
  runApp(const WooDiary());
}

class WooDiary extends StatelessWidget {
  const WooDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WooDiary',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size20 - Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}
