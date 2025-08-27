import 'package:flutter/material.dart';

class RecommendationTab extends StatelessWidget {
  // 생성자에서 context를 받지 않도록 수정했습니다.
  const RecommendationTab({super.key});

  @override
  Widget build(BuildContext context) {
    // 이미지와 똑같이 보이기 위한 정적 데이터
    final Map<String, dynamic> mbtiData = {
      'mbti_type': 'ISFJ',
      'emotion_change_percent': '10%',
      'emotion_change_description': '평소의 직관(N)적인 면이 두드러졌지만, 최근에 작성한 \'현실 고충\' 관련 게시물에서 약간의 어려움을 느끼신 것으로 보입니다.',
      'mbti_stats': {
        'E': 30, 'I': 70,
        'S': 60, 'N': 40,
        'F': 80, 'T': 20,
        'P': 80, 'J': 20,
      },
      'recommendations': [
        '맛있는 음식을 가족이나 친구와 함께 즐기기',
        '밀린 드라마나 영화 한 번에 보기',
        '가까운 산책로에서 가볍게 조깅하며 머리 식히기',
      ],
      'additional_contents': [
        {'title': '드라마', 'imageUrl': 'https://i.imgur.com/example1.png'},
        {'title': 'TVING', 'imageUrl': 'https://i.imgur.com/example2.png'},
        {'title': '음악', 'imageUrl': 'https://i.imgur.com/example3.png'},
      ],
    };

    return Scaffold(
      backgroundColor: const Color(0xFF110F0F),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. MBTI 분석 결과 섹션
            _buildMbtiAnalysisSection(mbtiData),
            const SizedBox(height: 32.0),

            // 2. 추천 목록 섹션
            _buildRecommendationList(mbtiData),
            const SizedBox(height: 32.0),

            // 3. 추가 콘텐츠 섹션
            _buildAdditionalContent(mbtiData),
          ],
        ),
      ),
    );
  }

  // --- ✨ 수정된 부분 ---
  // 설명 텍스트를 RichText로 변경하여 스타일을 적용
  Widget _buildMbtiAnalysisSection(Map<String, dynamic> data) {
    final mbtiStats = data['mbti_stats'] as Map<String, int>;
    final mbtiPairs = [
      {'label1': 'E', 'label2': 'I', 'value1': mbtiStats['E']!, 'value2': mbtiStats['I']!},
      {'label1': 'S', 'label2': 'N', 'value1': mbtiStats['S']!, 'value2': mbtiStats['N']!},
      {'label1': 'F', 'label2': 'T', 'value1': mbtiStats['F']!, 'value2': mbtiStats['T']!},
      {'label1': 'P', 'label2': 'J', 'value1': mbtiStats['P']!, 'value2': mbtiStats['J']!},
    ];

    // 기본 텍스트 스타일
    final baseTextStyle = TextStyle(color: Colors.grey[400], fontSize: 16, height: 1.5);
    // 강조 텍스트 스타일
    final boldTextStyle = baseTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold);
    final highlightTextStyle = baseTextStyle.copyWith(color: Colors.yellow, fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[900], // 배경색
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: const Text(
                  'MBTI',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(color: Colors.white24, thickness: 1),
              const SizedBox(height: 8),

              // MBTI 바 그래프
              for (var pair in mbtiPairs)
                _buildMbtiProgressRow(pair['label1'] as String, pair['label2'] as String, pair['value1'] as int, pair['value2'] as int),

              const SizedBox(height: 24.0),

              // MBTI 분석 문구
              Align(
                alignment: Alignment.center,
                child: Text(
                  data['mbti_type'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // RichText를 사용하여 텍스트 스타일링
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: baseTextStyle,
                  children: <TextSpan>[
                    const TextSpan(text: '오늘의 MBTI 분석 결과, '),
                    TextSpan(text: '감각(S) 성향', style: highlightTextStyle),
                    const TextSpan(text: '이 약 '),
                    TextSpan(text: data['emotion_change_percent'], style: boldTextStyle),
                    const TextSpan(text: ' 상승했습니다.\n'),
                    const TextSpan(text: '평소의 '),
                    TextSpan(text: '직관(N)적인 면', style: boldTextStyle),
                    const TextSpan(text: '이 두드러졌지만, 최근에 작성한 \'현실 고충\' 관련 게시물에서 약간의 '),
                    TextSpan(text: '어려움', style: boldTextStyle),
                    const TextSpan(text: '을 느끼신 것으로 보입니다.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  // --- 여기까지 수정 ---

  Widget _buildMbtiProgressRow(String label1, String label2, int value1, int value2) {
    final isLeftDominant = value1 > value2;
    final dominantValue = isLeftDominant ? value1 : value2;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text(
              label1,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Align(
                        alignment: isLeftDominant ? Alignment.centerLeft : Alignment.centerRight,
                        child: Container(
                          height: 30,
                          width: constraints.maxWidth * (dominantValue / 100),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            '$value1%',
                            style: TextStyle(
                              color: isLeftDominant ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text(
                            '$value2%',
                            style: TextStyle(
                              color: isLeftDominant ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 20,
            child: Text(
              label2,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- ✨ 수정된 부분 ---
  // 이미지에 나온 설명글과 추천 목록을 RichText로 수정
  Widget _buildRecommendationList(Map<String, dynamic> data) {
    final recommendations = data['recommendations'] as List<String>;
    final baseTextStyle = TextStyle(color: Colors.grey[400], fontSize: 16, height: 1.5);
    final boldTextStyle = baseTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold);
    final highlightTextStyle = baseTextStyle.copyWith(color: Colors.yellow, fontWeight: FontWeight.bold);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: baseTextStyle,
            children: <TextSpan>[
              const TextSpan(text: '이 단어는 다양한 의미로 해석될 수 있습니다.\n누군가의 날카로운 '),
              TextSpan(text: '지적(팩트폭행)', style: boldTextStyle),
              const TextSpan(text: '을 받았거나, 하려던 일이 뜻대로 풀리지 않았을 가능성이 있습니다.'),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          '이럴 땐 혼자서 깊이 고민하는 것도 좋지만, 오히려 기분 전환이 필요할 수도 있습니다.',
          style: baseTextStyle,
        ),
        const SizedBox(height: 24.0),
        Text(
          '사용자님의 성향에 맞춰 다음을 추천드려요.',
          style: boldTextStyle.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16.0),
        ...recommendations.map((rec) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('•  ', style: highlightTextStyle),
              Expanded(
                child: Text(
                  rec,
                  style: highlightTextStyle.copyWith(fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        )).toList(),
        const SizedBox(height: 24.0),
        Text(
          '작은 변화가 기분을 크게 바꿔줄 수 있습니다.',
          style: baseTextStyle,
        ),
      ],
    );
  }
  // --- 여기까지 수정 ---

  Widget _buildAdditionalContent(Map<String, dynamic> data) {
    final contents = data['additional_contents'] as List<Map<String, dynamic>>;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '절망 속에 있다면, 이건 당신의 해방이 될 거예요.',
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: contents.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: _buildContentCard(contents[index]['title'], contents[index]['imageUrl']),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContentCard(String title, String imageUrl) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey[800], // 이미지 로딩 전 배경색
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          // 이미지 로딩 중/에러 발생 시 처리
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return const Center(child: Text('이미지 로드 실패', style: TextStyle(color: Colors.white)));
          },
        ),
      ),
    );
  }
}
