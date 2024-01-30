import 'package:flutter/material.dart';
import 'package:woodiary/constants/sizes.dart';
import 'package:woodiary/screens/auth/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        primaryColor: const Color(0xff73a379),
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
      home: const AuthScreen(),
    );
  }
}
