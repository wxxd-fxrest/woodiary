import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woodiary/components/drawer_widget.dart';
import 'package:woodiary/components/nav_tab.dart';
import 'package:woodiary/constants/gaps.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Record video')),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffbcd593),
        title: const Text(
          'WooDiary',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
      drawer: const DrawerWidget(),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavTab(
              text: "Home",
              isSelected: _selectedIndex == 0,
              icon: FontAwesomeIcons.house,
              onTap: () => _onTap(0),
            ),
            NavTab(
              text: "Discover",
              isSelected: _selectedIndex == 1,
              icon: FontAwesomeIcons.magnifyingGlass,
              onTap: () => _onTap(1),
            ),
            Gaps.h24,
            GestureDetector(
              onTap: _onPostVideoButtonTap,
              child: Container(
                decoration: const BoxDecoration(color: Colors.amber),
                width: 30,
                height: 30,
              ),
            ),
            Gaps.h24,
            NavTab(
              text: "Inbox",
              isSelected: _selectedIndex == 3,
              icon: FontAwesomeIcons.message,
              onTap: () => _onTap(3),
            ),
            NavTab(
              text: "Profile",
              isSelected: _selectedIndex == 4,
              icon: FontAwesomeIcons.user,
              onTap: () => _onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}
