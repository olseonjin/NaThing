import 'package:flutter/material.dart';
import 'notificationpage.dart';
import 'home.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildAppBar(context);
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 왼쪽 아이콘 (Drawer 오픈)
          Builder(
            builder: (context) => InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset('assets/icon/bar.png', width: 21, height: 21),
            ),
          ),

          // 가운데 로고 (Home으로 이동)
          Expanded(
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
                child: Image.asset('assets/image/logo.png', height: 24),
              ),
            ),
          ),

          // 오른쪽 아이콘 (알림 페이지로 이동)
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
            child: Image.asset('assets/icon/bell.png', height: 24),
          ),
        ],
      ),
    );
  }
}
