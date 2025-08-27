import 'package:flutter/material.dart';
import '../class/post.dart';
import '../issuedetailpage.dart';

// --- 그래디언트 텍스트 위젯 ---
class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        super.key,
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

// --- 각 포스트 아이템을 위한 위젯 ---
class PostItem extends StatefulWidget {
  final Post post;
  const  PostItem({super.key, required this.post});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeHendOverlay();
    super.dispose();
  }

  // HEND 공감 팝업을 보여주는 함수
  void _showHendOverlay() {
    if (_overlayEntry != null) {
      _removeHendOverlay();
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // 전체 화면을 덮는 투명한 배경 (팝업 밖 터치 감지용)
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeHendOverlay,
              child: Container(color: Colors.transparent),
            ),
          ),
          // HEND 팝업 내용
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0.0, -70.0), // 버튼 위로 60px 위치
            child: _buildHendOverlayContent(),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  // HEND 공감 팝업을 제거하는 함수
  void _removeHendOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // HEND 팝업 내용
  Widget _buildHendOverlayContent() {
    // HEND 데이터: 글자, 의미, 색상
    final hendData = [
      {'letter': 'H', 'meaning': '흘림', 'color': const Color(0xFFFFF5CB)}, // FFF5CB
      {'letter': 'E', 'meaning': '이해', 'color': const Color(0xFFAAC6F7)}, // AAC6F7
      {'letter': 'N', 'meaning': '남음', 'color': const Color(0xFFC1FFCA)}, // C1FFCA
      {'letter': 'D', 'meaning': '담음', 'color': const Color(0xFFEBC0F9)}, // EBC0F9
    ];

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFF242222), // 어두운 회색 배경
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: hendData.asMap().entries.map((entry) {
            final data = entry.value;
            return InkWell(
              onTap: () {
                print('${data['letter']} (${data['meaning']}) 공감!');
                _removeHendOverlay(); // 공감 후 팝업 닫기
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data['letter'] as String,
                      style: TextStyle(
                        color: data['color'] as Color,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data['meaning'] as String,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // 일반 버튼 (서포트)
  Widget _buildPostFooterButton(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
          color: const Color(0xFF242222),
        borderRadius: BorderRadius.circular(18),
        //border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.normal, fontSize: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _removeHendOverlay();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IssueDetailPage(
              title: widget.post.user_nickname ?? '익명',
              description: widget.post.content ?? '',
              blurStrength: 5.0,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.grey[800], height: 10, thickness: 1),
            Row(
              children: [
                const CircleAvatar(
                  radius: 19,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image(
                      image: AssetImage('assets/icon/profile.png'),
                      fit: BoxFit.cover,
                      width: 60.0,
                      height: 60.0,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.post.user_nickname ?? 'Nathing',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16),
                      ),
                      const Spacer(), // Spacer will now work
                      Text(
                        '기대 · 11:59 후 소멸',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    widget.post.content ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CompositedTransformTarget(
                      link: _layerLink,
                      child: GestureDetector(
                        onTap: _showHendOverlay,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF242222),
                            borderRadius: BorderRadius.circular(50),
                            //border: Border.all(color: Colors.grey.shade700),
                          ),
                          child: const GradientText(
                            'HEND',
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFFF5CB),
                                const Color(0xFFAAC6F7),
                                const Color(0xFFC1FFCA),
                                const Color(0xFFEBC0F9),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildPostFooterButton('서포트', Colors.white),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(Icons.sync, color: Colors.grey[400], size: 22),
                    const SizedBox(width: 12),
                    Icon(Icons.more_horiz, color: Colors.grey[400], size: 22),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
