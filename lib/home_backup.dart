import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appbar.dart';
import 'isuuepage.dart';
import 'issuedetailpage.dart';
import 'provider/postProvider.dart';
import 'class/post.dart';
import 'wiget/buildissueitem.dart';
import 'recommendationpage.dart';
import 'dart:ui';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isReady = false;
  bool _isEditing = false;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        setState(() {
          _isEditing = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF110F0F),
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
          // 전체 배경 이미지
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/image/background.png',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          // AppBar + Body
          SafeArea(
            child: Column(
              children: [
                Appbar(), // Appbar 위젯 삽입
                _buildTabBar(),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildHomeContent(),
                      RecommendationTab(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      tabs: const [
        Tab(text: '홈'),
        Tab(text: '감정'),
      ],
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: _defaultBody(),
    );
  }

  Widget _defaultBody() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.asset('assets/image/starbucks.png'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('글쓰기', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade600.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade600),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('오늘 감정은 어떠셨나요?', style: TextStyle(color: Colors.white)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextField(
                          controller: _textController,
                          focusNode: _focusNode,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: '글을 작성해 보세요',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            isCollapsed: true,
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) {
                            setState(() {
                              _isEditing = false;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        final text = _textController.text.trim();
                        if (text.isNotEmpty) {
                          Provider.of<postProvider>(context, listen: false).writePost(text);
                          setState(() {
                            _textController.clear();
                            _isEditing = false;
                            // 새로고침
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation1, animation2) => const Home(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade700,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text(
                        '흘려보내기',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('AI피드백 보러가기', style: TextStyle(color: Colors.grey)),
                ),
                const SizedBox(height: 20),
                _buildIssueBody(),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // 이슈 박스
  Widget _buildIssueBody() {
    // 전체 아이템 리스트
    Provider.of<postProvider>(context, listen: false).getPost();
    List<Post> posts = Provider.of<postProvider>(context, listen: false).posts;
    // posts를 위젯으로 맵핑
    final List<Widget> issueItems = posts.map((post) {
      return IssueItem(
        post.user_nickname,
        post.content,
        post.created_at,
        onTap: _showIssueContent,
      );
    }).toList();

    // 최대 3개만 표시
    final visibleItems = issueItems.take(3).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade600),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // 더보기 누르면 Homepage로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IssuePage()),
              );
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '이슈',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '더보기 >',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...visibleItems,
        ],
      ),
    );
  }

  /*
  Widget _buildIssueItem(String title, String description, String createdAt) {
    final created = DateTime.parse(createdAt);
    final now = DateTime.now();
    final diff = now.difference(created);
    final hours = diff.inMinutes / 60.0;
    double blur = (hours / 24.0) * 10.0;
    if (blur < 0) blur = 0;
    if (blur > 10) blur = 10;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            // InkWell이 가로 전체를 차지하도록 SizedBox.expand 사용
            SizedBox(
              width: double.infinity,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _showIssueContent(context, title, description);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(0),
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
              ),
            ),
            if (blur > 0)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  */

  void _showIssueContent(BuildContext context, String title, String description, double blurStrength) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IssueDetailPage(
            title: title,
            description: description,
            blurStrength: blurStrength
        ),
      ),
    );
  }
}

