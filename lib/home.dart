import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'appbar.dart';
import 'provider/postProvider.dart';
import 'class/post.dart';
import 'recommendationpage.dart';
import 'drawerpage.dart';
import 'wiget/postitem.dart';
import 'dart:ui';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  int _currentPage = 0;
  final TextEditingController _postTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
    _pageController.addListener(() {
      if (_pageController.page?.round() != _currentPage) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });

    Provider.of<postProvider>(context, listen: false).getPost();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    _postTextController.dispose();
    super.dispose();
  }

  void _showWritingSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: _buildWritingContent(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //배경색
      backgroundColor: const Color(0xFF110F0F),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showWritingSheet,
        backgroundColor: Colors.black,
        child: Image.asset(
          'assets/logo.png',
          width: 30,
          height: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          children: [
            const Appbar(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildHomeContent(),
                  const RecommendationTab(),
                ],
              ),
            ),
          ],
        ),
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
    return Consumer<postProvider>(
      builder: (context, provider, child) {
        if (provider.posts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRealtimeEmotionSection(provider.posts),
              const SizedBox(height: 20),
              _buildPostFeed(provider.posts),
              _buildRecommendationSection(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWritingContent() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('취소', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFF242222)),
                  ),
                  onPressed: () async {
                    final content = _postTextController.text.trim();
                    if (content.isNotEmpty) {
                      try {
                        await Provider.of<postProvider>(context, listen: false).writePost(content);
                        _postTextController.clear(); // 텍스트 필드 비우기
                        Navigator.pop(context); // 모달 닫기
                      } catch (e) {
                        print('게시물 작성 실패: $e');
                      }
                    }
                  },
                  child: const GradientText(
                    'HEND',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFF5CB),
                        Color(0xFFAAC6F7),
                        Color(0xFFC1FFCA),
                        Color(0xFFEBC0F9),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: TextField(
                controller: _postTextController,
                autofocus: true,
                maxLines: null,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '오늘 당신의 감정, HEND 하세요',
                  hintStyle: TextStyle(color: Colors.grey[600], fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRealtimeEmotionSection(List<Post> posts) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView(
            controller: _pageController,
            children: [
              _buildEmotionPageContent(
                title: '실시간 감정',
                icon: Icons.access_time,
                posts: posts.take(3).toList(),
              ),
              _buildEmotionPageContent(
                title: '감정 캠페인',
                icon: Icons.flag_outlined,
                posts: posts.take(3).toList(),
              ),
              _buildEmotionPageContent(
                title: '감정 휴지통',
                icon: Icons.delete_outline,
                posts: posts.take(3).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildPageIndicator(),
      ],
    );
  }

  Widget _buildEmotionPageContent({required String title, required IconData icon, required List<Post> posts}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.yellow, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return _buildRealtimeEmotionItem(posts[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRealtimeEmotionItem(Post post) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '익명 - ${post.content}',
              style: const TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'N',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.yellow : Colors.grey[700],
          ),
        );
      }),
    );
  }

  /// 게시물 피드 리스트 위젯
  Widget _buildPostFeed(List<Post> posts) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            PostItem(post: posts[index]),
          ],
        );
      },
    );
  }

  Widget _buildRecommendationSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '기분이 좋은 당신에게, 이건 선물 같을 거예요.',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                //_buildProductCard('assets/image/recommendation1.png'),
                const SizedBox(width: 12),
                //_buildProductCard('assets/image/recommendation2.png'),
                const SizedBox(width: 12),
                //('assets/image/recommendation3.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imagePath,
        width: 150,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 150,
            height: 150,
            color: Colors.grey[800],
            child: const Center(child: Text('이미지 없음', style: TextStyle(color: Colors.white))),
          );
        },
      ),
    );
  }
}
