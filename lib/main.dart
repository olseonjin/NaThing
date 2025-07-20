import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/postProvider.dart';
import 'loginpage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => postProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(), // 처음엔 login 화면
    );
  }
}
