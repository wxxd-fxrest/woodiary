import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woodiary/constants/sizes.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffdeeac9),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage(
                'assets/image/0b2fd4801d03fde3a349ac1ffca4dc73.jpg',
              ),
            ),
            otherAccountsPictures: [
              GestureDetector(
                onTap: () {
                  print('edit click');
                },
                child: const FaIcon(
                  FontAwesomeIcons.pen,
                  size: Sizes.size16,
                  color: Color(0xff4e7055),
                ),
              ),
            ],
            accountName: const Text(
              '로기',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            accountEmail: const Text(
              'wood@naver.com',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            arrowColor: Colors.green,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xff73a379),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(Icons.home),
              iconColor: Color(0xff73a379),
              focusColor: Color(0xff73a379),
              title: Text('홈'),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(Icons.home),
              iconColor: Color(0xff73a379),
              focusColor: Color(0xff73a379),
              title: Text('홈'),
              trailing: Icon(Icons.navigate_next),
            ),
          ),
        ],
      ),
    );
  }
}
