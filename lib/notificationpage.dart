import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('알림')),
      body: const Center(child: Text('알림 페이지')),
    );
  }
}