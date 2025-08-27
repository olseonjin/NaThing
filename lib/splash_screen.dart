import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {

    _controller = VideoPlayerController.asset('assets/video/logo_black.mp4')
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.setLooping(true); // 반복 재생
        _controller.setPlaybackSpeed(0.75);
        _controller.play(); // 자동 재생
        _loadAssetsAndNavigate(); // 여기서 이미지 로딩 및 다음 화면 이동
      });

    super.initState();
  }

  Future<void> _loadAssetsAndNavigate() async {
    // 이미지 등 리소스 프리로드
    //await precacheImage(const AssetImage('assets/image/background.png'), context);
    //await precacheImage(const AssetImage('assets/image/starbucks.png'), context);


    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // 리소스 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
        : const SizedBox.shrink()
      ),
    );
  }
}
