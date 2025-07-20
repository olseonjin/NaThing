import 'package:flutter/material.dart';
import 'package:nathing/provider/postProvider.dart';
import 'package:provider/provider.dart';
import 'class/post.dart';
import 'issuedetailpage.dart';
import 'appbar.dart';

class IssuePage extends StatelessWidget {
  const IssuePage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<postProvider>(context, listen: false).getPost();
    List<Post> posts = Provider.of<postProvider>(context, listen: false).posts;
    // posts를 위젯으로 맵핑
    final List<Widget> issueItems = posts.map((post) {
      return _buildIssueItem(context, post.user_nickname, post.content);
    }).toList();

    return Scaffold(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // Handle back button press
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.arrow_circle_left_outlined,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                          "사람 이름",
                                          style: TextStyle(color: Colors.white, fontSize: 16)
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Text(
                            '이슈 전체보기',
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // 이슈 리스트를 박스+패딩으로 감싸기
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade600),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...issueItems.map((item) => Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0), // 각 아이템 위아래 패딩
                                  child: item,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueItem(BuildContext context, String title, String description) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _showIssueContent(context, title, description);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showIssueContent(BuildContext context, String title, String description) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IssueDetailPage(
            title: title,
            description: description
        ),
      ),
    );
  }
}