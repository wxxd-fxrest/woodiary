import 'package:flutter/material.dart';
import 'package:woodiary/constants/sizes.dart';
import 'package:woodiary/screens/auth/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:woodiary/screens/main_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const WooDiary());
}

class WooDiary extends StatefulWidget {
  const WooDiary({super.key});

  @override
  State<WooDiary> createState() => _WooDiaryState();
}

class _WooDiaryState extends State<WooDiary> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    // FirebaseAuth의 로그인 상태 변경 이벤트를 구독
    _auth.authStateChanges().listen((User? user) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

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
      home: user != null ? const MainScreen() : const AuthScreen(),
    );
  }
}
