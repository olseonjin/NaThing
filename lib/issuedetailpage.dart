import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appbar.dart';
import 'drawerpage.dart';
import 'provider/postProvider.dart';

class IssueDetailPage extends StatefulWidget {
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
  State<IssueDetailPage> createState() => _IssueDetailPageState();
}

class _IssueDetailPageState extends State<IssueDetailPage> {
  String? aiFeedback;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAIFeedback();
  }

  Future<void> fetchAIFeedback() async {
    // mounted 속성을 확인하여 위젯이 여전히 트리에 있는지 확인합니다.
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    final provider = Provider.of<postProvider>(context, listen: false);
    final result = await provider.fetchAIFeedback(widget.description);

    // 비동기 작업 후에도 위젯이 마운트 상태인지 다시 확인합니다.
    if (mounted) {
      setState(() {
        aiFeedback = result;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double blur = widget.blurStrength;
    return Scaffold(
      backgroundColor: const Color(0xFF110F0F),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const Appbar(), // Appbar 위젯 이름이 Appbar()라고 가정합니다.
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 뒤로가기 버튼, 작성자, 시간
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                  child: Image(
                                    image: AssetImage('assets/icon/profile.png'),
                                    fit: BoxFit.cover,
                                    width: 36.0,
                                    height: 36.0,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                  "사람 이름", // 실제 데이터로 교체 필요
                                  style: TextStyle(color: Colors.white, fontSize: 16)
                              ),
                              const Spacer(),
                              const Text(
                                  "12:04:56", // 실제 데이터로 교체 필요
                                  style: TextStyle(color: Colors.grey, fontSize: 14)
                              ),
                            ],
                          ),
                        ),
                        // 제목
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            widget.title,
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // 블러 처리된 이미지
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(16),
                        //     child: Stack(
                        //       children: [
                        //         Image.asset(
                        //           'assets/image/starbucks.png',
                        //           width: double.infinity,
                        //           height: 180,
                        //           fit: BoxFit.cover,
                        //           errorBuilder: (context, error, stackTrace) {
                        //             return Container(
                        //               width: double.infinity,
                        //               height: 180,
                        //               color: Colors.grey[800],
                        //               child: const Center(child: Text('이미지를 불러올 수 없습니다.', style: TextStyle(color: Colors.white))),
                        //             );
                        //           },
                        //         ),
                        //         Positioned.fill(
                        //           child: BackdropFilter(
                        //             filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                        //             child: Container(
                        //               color: Colors.black.withOpacity(0.1),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // 본문 내용
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            widget.description,
                            style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
                          ),
                        ),
                        // AI 피드백
                        if (isLoading)
                          const Center(child: CircularProgressIndicator())
                        else if (aiFeedback != null)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'AI 피드백 (MBTI 분석 결과)',
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  aiFeedback!,
                                  style: const TextStyle(color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        // 하단 아이콘 버튼들
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite_border, color: Colors.white54, size: 28),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.bookmark_border, color: Colors.white54, size: 28),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.share, color: Colors.white54, size: 28),
                                onPressed: () {},
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
