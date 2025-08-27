import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // Drawer의 전체적인 디자인
    return Drawer(
      backgroundColor: const Color(0xFF1C1C1E), // Drawer 배경색
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // 1. 상단 프로필 섹션
          _buildDrawerHeader(context),

          // 2. 메뉴 섹션
          _buildDrawerSectionTitle("계정 정보"),
          _buildDrawerItem(context, text: '내 정보 보기', onTap: () => _navigateTo(context, '/profile')),
          _buildDrawerItem(context, text: '내 피드', onTap: () => _navigateTo(context, '/feed')),
          _buildDrawerItem(context, text: '보관함', onTap: () => _navigateTo(context, '/archive')),
          _buildDrawerItem(context, text: '프로필 편집', onTap: () => _navigateTo(context, '/edit-profile')),
          const Divider(color: Colors.grey),

          _buildDrawerSectionTitle("감정들"),
          _buildDrawerItem(context, text: '기쁨 (즐거움, 행복감, 만족)', onTap: () {}),
          _buildDrawerItem(context, text: '슬픔 (상실, 외로움, 우울함)', onTap: () {}),
          _buildDrawerItem(context, text: '분노 (화남, 짜증, 불쾌함)', onTap: () {}),
          _buildDrawerItem(context, text: '두려움 (불안, 공포, 긴장)', onTap: () {}),
          _buildDrawerItem(context, text: '놀람 (예기치 못한, 긍정 또는 부정)', onTap: () {}),
          _buildDrawerItem(context, text: '혐오 (불쾌, 거부)', onTap: () {}),
          _buildDrawerItem(context, text: '수치심 (잘못, 실수, 부끄러움)', onTap: () {}),
          _buildDrawerItem(context, text: '죄책감 (도덕적 책임감)', onTap: () {}),
          _buildDrawerItem(context, text: '사랑 (애정, 호의, 친밀감)', onTap: () {}),
          _buildDrawerItem(context, text: '기대 (희망, 설렘)', onTap: () {}),
          _buildDrawerItem(context, text: '기타', onTap: () {}),
          const Divider(color: Colors.grey),

          _buildDrawerSectionTitle("커뮤니티"),
          _buildDrawerItem(context, text: '실시간 감정', onTap: () {}),
          _buildDrawerItem(context, text: '감정 캠페인', onTap: () {}),
          _buildDrawerItem(context, text: '감정 휴지통', onTap: () {}),
          const Divider(color: Colors.grey),

          _buildDrawerItem(context, text: '설정', icon: Icons.settings, onTap: () {}),
        ],
      ),
    );
  }

  /// Drawer 상단의 헤더 위젯
  Widget _buildDrawerHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              const SizedBox(width: 16),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nathing',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '#행복지수 #비상구',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeaderButton(context, '프로필 편집'),
              _buildHeaderButton(context, '보관함'),
              _buildHeaderButton(context, '내 피드'),
            ],
          ),
        ],
      ),
    );
  }

  /// 헤더에 들어가는 버튼 위젯
  Widget _buildHeaderButton(BuildContext context, String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: Text(text, style: const TextStyle(fontSize: 12)),
        ),
      ),
    );
  }

  /// 각 메뉴 섹션의 제목 위젯
  Widget _buildDrawerSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  /// 터치 가능한 메뉴 아이템 위젯
  Widget _buildDrawerItem(BuildContext context, {IconData? icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: icon != null ? Icon(icon, color: Colors.white70) : null,
      title: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
      onTap: onTap,
      dense: true,
    );
  }

  /// 페이지 이동을 위한 헬퍼 함수 (예시)
  void _navigateTo(BuildContext context, String routeName) {
    // Drawer를 닫고 새로운 페이지로 이동
    Navigator.pop(context);
    // Navigator.pushNamed(context, routeName); // 실제 라우팅 로직
    print("Navigating to $routeName"); // 임시로 print문 사용
  }
}
