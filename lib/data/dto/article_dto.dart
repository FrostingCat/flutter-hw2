class ArticleDto {
  String title;
  String? author;
  String description;
  String urlToImage;
  DateTime publshedAt;
  String content;
  String articleUrl;

  ArticleDto(
      {required this.title,
      required this.description,
      this.author,
      required this.content,
      required this.publshedAt,
      required this.urlToImage,
      required this.articleUrl});
}
