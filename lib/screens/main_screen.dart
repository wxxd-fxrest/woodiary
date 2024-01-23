import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woodiary/components/drawer_widget.dart';
import 'package:woodiary/constants/sizes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // int _selectedIndex = 0;

  // void _onTap(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  // void _onPostVideoButtonTap() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => Scaffold(
  //         appBar: AppBar(title: const Text('Record video')),
  //       ),
  //       fullscreenDialog: true,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: const Color(0xffbcd593),
      //   title: const Text(
      //     'WooDiary',
      //     style: TextStyle(
      //       color: Colors.black87,
      //     ),
      //   ),
      // ),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(Sizes.size20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.indent,
                      color: Color(0xff73a379),
                    ),
                  );
                },
              ),
              const FaIcon(
                FontAwesomeIcons.house,
                color: Color(0xff73a379),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('plus click');
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.circlePlus,
                              size: Sizes.size20 + Sizes.size28,
                              color: Color(0xff73a379),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      //  BottomAppBar(
      //   elevation: 0,
      //   surfaceTintColor: Colors.white,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       // NavTab(
      //       //   text: "Home",
      //       //   isSelected: _selectedIndex == 0,
      //       //   icon: FontAwesomeIcons.house,
      //       //   onTap: () => _onTap(0),
      //       // ),
      //       // NavTab(
      //       //   text: "Discover",
      //       //   isSelected: _selectedIndex == 1,
      //       //   icon: FontAwesomeIcons.magnifyingGlass,
      //       //   onTap: () => _onTap(1),
      //       // ),
      //       // Gaps.h24,
      // GestureDetector(
      //   onTap: _onPostVideoButtonTap,
      //   child: Container(
      //     decoration: const BoxDecoration(
      //       color: Colors.amber,
      //     ),
      //     width: 30,
      //     height: 30,
      //   ),
      // ),
      //       // Gaps.h24,
      //       // NavTab(
      //       //   text: "Inbox",
      //       //   isSelected: _selectedIndex == 3,
      //       //   icon: FontAwesomeIcons.message,
      //       //   onTap: () => _onTap(3),
      //       // ),
      //       // NavTab(
      //       //   text: "Profile",
      //       //   isSelected: _selectedIndex == 4,
      //       //   icon: FontAwesomeIcons.user,
      //       //   onTap: () => _onTap(4),
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }
}
