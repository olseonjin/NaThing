import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class postProvider with ChangeNotifier {
  int? _id;
  String? _content;
  String? _image_url;
  String? _user_nickname;
  String? _created_at;

  // Getters
  int? get id => _id;
  String? get image_url => _image_url;
  String? get content => _content;
  String? get user_nickname => _user_nickname;
  String? get created_at => _created_at;

  //게시물 가져오기
  Future<void> getPost() async {
    final url = 'http://10.0.2.2:8080/api/posts'; // 포트 번호 포함해야 함

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body); // 바로 리스트로 파싱
        print("게시글 가져옴: $data");

        for (var item in data) {
          _id = item['id'];
          _content = item['content'] ?? "";
          _image_url = item['image_url'];
          _user_nickname = item['user_nickname'];
          _created_at = item['created_at'];

          if (id != null) {
            print('조회한 게시물: $item');
          } else {
            print('ID가 null입니다: $item');
          }
        }

        notifyListeners();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (error) {
      print('Error loading posts: $error');
    }
  }

  // 게시물 업데이트
  Future<void> updatePost(int id, String? content, String? image_url, String? user_nickname, String? created_at) async {
    final url = 'http://10.0.2.2:8080/api/posts';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id': _id,
          'content': _content,
          'image_url': _image_url,
          'user_nickname': _user_nickname,
          'created_at': _created_at,
        }),
      );
      if (response.statusCode == 200) {
        _id = id;
        _content = content;
        _image_url = image_url;
        _user_nickname = user_nickname;
        _created_at = created_at;
        notifyListeners(); // 상태 변경 통지
      } else {
        throw Exception('Failed to update user data');
      }
    } catch (error) {
      throw error; // 에러 처리
    }
  }

}
