import 'package:flutter/material.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // initState 대신 didChangeDependencies를 사용하거나,
  // initState에서 WidgetsBinding.instance.addPostFrameCallback을 사용해야 해.

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 여기서는 context가 완전히 준비된 상태이므로 precacheImage를 호출해도 안전해!
    _loadAssetsAndNavigate();
  }

  Future<void> _loadAssetsAndNavigate() async {
    // 이미지 프리로드
    await precacheImage(const AssetImage('assets/image/background.png'), context);
    await precacheImage(const AssetImage('assets/image/starbucks.png'), context);

    // 약간의 대기 (브랜드 노출 시간 등)
    //Future.delayed(const Duration(seconds: 1));

    // Home 화면으로 전환
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로고
            Image(
              image: AssetImage('assets/logo.png'),
              height: 80,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}