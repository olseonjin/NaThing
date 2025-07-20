class Post {
  final int id;
  final String content;
  final String image_url;
  final String user_nickname;
  final String created_at;

  Post({
    required this.id,
    required this.content,
    required this.image_url,
    required this.user_nickname,
    required this.created_at,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
      image_url: json['image_url'],
      user_nickname: json['user_nickname'],
      created_at: json['created_at'],
    );
  }
}
