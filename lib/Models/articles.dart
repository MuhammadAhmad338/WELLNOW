class Article {
  final String url;
  final String content;

  Article({required this.url, required this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      url: json['url'],
      content: json['content'],
    );
  }
}