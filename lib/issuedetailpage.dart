import 'dart:ui';
import 'package:flutter/material.dart';
import 'appbar.dart';

class IssueDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final double blurStrength;

  const IssueDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.blurStrength,
  });

  @override
  Widget build(BuildContext context) {
    // 블러 강도 예시 (원하는 값으로 조절)
    double blur = blurStrength;
    return Scaffold(
      drawer: Drawer( // drawer 연결
        backgroundColor: Colors.grey[900],
        child: ListView(
          children: const [
            DrawerHeader(
              //decoration: BoxDecoration(color: Colors.grey),
              child: Text('메뉴', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: Text('홈', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: Text('설정', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/background.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Appbar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start, // 시작점에 정렬 (아이콘, 이름)
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // Handle back button press
                                    print("상단바 클릭");
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.arrow_circle_left_outlined,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8), // 아이콘과 이름 사이에 간격 추가 (선택 사항)
                                      const Text( // const를 붙여주는 게 성능에 좋아!
                                          "사람 이름",
                                          style: TextStyle(color: Colors.white, fontSize: 16)
                                      ),
                                      const Text( // const를 붙여주는 게 성능에 좋아!
                                          "12:04:56",
                                          style: TextStyle(color: Colors.white, fontSize: 16)
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              title,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        // 블러 처리된 이미지를 제목 아래로 이동
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 16.0, right: 16.0, bottom: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/image/starbucks.png',
                                  width: double.infinity,
                                  height: 160,
                                  fit: BoxFit.cover,
                                ),
                                Positioned.fill(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                                    child: Container(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            description,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('하단 아이콘 클릭');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.favorite_border,
                                color: Colors.white54,
                                size: 28,
                              ),
                              const SizedBox(width: 32),
                              const Icon(
                                Icons.bookmark_border,
                                color: Colors.white54,
                                size: 28,
                              ),
                              const SizedBox(width: 32),
                              const Icon(
                                Icons.share,
                                color: Colors.white54,
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
