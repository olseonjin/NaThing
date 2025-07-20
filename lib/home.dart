import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appbar.dart';
import 'isuuepage.dart';
import 'issuedetailpage.dart';
import 'provider/postProvider.dart';
import 'class/post.dart';

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
      backgroundColor: Colors.black,
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
          Positioned.fill(
            child: Image.asset(
              'assets/image/background.png',
              fit: BoxFit.cover,
            ),
          ),
          // AppBar + Body
          SafeArea(
            child: Column(
              children: [
                Appbar(), // Appbar 위젯 삽입
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildHomeContent(),
                      _buildRecommendationTab(),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    border: const Border(
                      top: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: _buildBottomNavigationBar(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Text('추천 탭 내용', style: TextStyle(color: Colors.white)),
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
        Tab(text: '추천'),
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
                      child: _isEditing
                          ? Container(
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
                                autofocus: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: '글을 작성해 보세요',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  isCollapsed: true,
                                ),
                                onSubmitted: (_) {
                                  setState(() {
                                    _isEditing = false;
                                  });
                                },
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isEditing = true;
                                });
                              },
                              child: Container(
                                height: 40,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Text(
                                  _textController.text.isEmpty ? '글을 작성해 보세요' : _textController.text,
                                  style: TextStyle(color: _textController.text.isEmpty ? Colors.grey : Colors.white),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        final text = _textController.text.trim();
                        if (text.isNotEmpty) {
                          // 이벤트 발생
                          Provider.of<postProvider>(context, listen: false).writePost(text);
                          // 입력창 초기화 및 편집 종료
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
      return _buildIssueItem(post.user_nickname, post.content);
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

  Widget _buildIssueItem(String title, String description) {
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

  Widget _buildMainUI() {
    return Scaffold(
      body: Stack(
        children: [
          // 전체 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/image/background.png',
              fit: BoxFit.cover,
            ),
          ),
          // AppBar + TabBar + Body 포함
          SafeArea(
            child: Column(
              children: [
                // AppBar
                Appbar(),
                if (false) // _isIssueExpanded 관련 변수 및 코드 전체 삭제
                  _buildTabBar(),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildHomeContent(),  // 이미 ScrollView로 구성됨
                      SingleChildScrollView( // 스크롤 가능하게 감쌈
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            '추천 탭 내용',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    border: const Border(
                      top: BorderSide(color: Colors.grey), // 구분선
                    ),
                  ),
                  child: _buildBottomNavigationBar(),
                ),
              ],
            ),
          ),
        ],
      ),
      //bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

Widget _buildBottomNavigationBar() {
  return BottomNavigationBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    currentIndex: 2,
    items: const [
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icon/total.png'), color: Colors.grey),
        activeIcon: ImageIcon(AssetImage('assets/icon/total.png'), color: Colors.white),
        label: '전체보기',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icon/news.png'), color: Colors.grey),
        activeIcon: ImageIcon(AssetImage('assets/icon/news.png'), color: Colors.white),
        label: 'N뉴스',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icon/home.png'), color: Colors.grey),
        activeIcon: ImageIcon(AssetImage('assets/icon/home.png'), color: Colors.white),
        label: '홈',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icon/campaign.png'), color: Colors.grey),
        activeIcon: ImageIcon(AssetImage('assets/icon/campaign.png'), color: Colors.white),
        label: '캠페인',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/icon/profile.png'), color: Colors.grey),
        activeIcon: ImageIcon(AssetImage('assets/icon/profile.png'), color: Colors.white),
        label: '프로필',
      ),
    ],
  );
}
