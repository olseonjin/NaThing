import 'package:flutter/material.dart';
import 'appbar.dart';
import 'issuepage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isReady = false;
  bool _isIssueExpanded = false; // 이슈 펼침 여부 상태

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // 위젯이 렌더링된 이후 이미지 미리 로딩
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await precacheImage(const AssetImage('assets/image/background.png'), context);
      await precacheImage(const AssetImage('assets/image/starbucks.png'), context);

      // 약간의 여유시간을 둘 수도 있음
      await Future.delayed(const Duration(milliseconds: 400));

      setState(() {
        _isReady = true; // 로딩 완료 → 메인 화면으로
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
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

    return _buildMainUI(); // 여기에 기존 Scaffold 넣기
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
      child: !_isIssueExpanded
          ? _defaultBody()
          : _buildIssueBody(),
    );
  }


  Widget _defaultBody() {
    return Column(
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
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Text('글을 작성해 보세요', style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
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
              _buildIssueBody(),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildIssueBody() {
    // 전체 아이템 리스트
    final List<Widget> issueItems = [
      _buildIssueItem('unknown', '사진/동영상 - 나띵을 활용법에 대하여 정리해봤어! 궁금해요'),
      _buildIssueItem('감정없는 감정 premium', '하..진짜 회사 때려치울까 누구는 하라하고 누구는 미안해미안해하지마'),
      _buildIssueItem('unknown', '내가 나띵하면서 느낀건데, 왜 이제서야 이런 플랫폼이 생각'),
      _buildIssueItem('unknown', '내가 나띵하면서 느낀건데, 왜 이제서야 이런 플랫폼이 생각'),
      _buildIssueItem('unknown', 'unknown title'),
      _buildIssueItem('unknown', '사진/동영상 - 나띵을 활용법에 대하여 정리해봤어! 궁금해요'),
      _buildIssueItem('감정없는 감정 premium', '하..진짜 회사 때려치울까 누구는 하라하고 누구는 미안해미안해하지마'),
      _buildIssueItem('unknown', '내가 나띵하면서 느낀건데, 왜 이제서야 이런 플랫폼이 생각'),
      _buildIssueItem('unknown', 'unknown title'),
    ];

    // 최대 3개만 표시하고 싶다면:
    final visibleItems = _isIssueExpanded ? issueItems : issueItems.take(3).toList();

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
              setState(() {
                _isIssueExpanded = !_isIssueExpanded;
              });
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
                  Text(
                    _isIssueExpanded ? '닫기 >' : '더보기 >',
                    style: const TextStyle(color: Colors.grey),
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
                if (!_isIssueExpanded)
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
