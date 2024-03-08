import 'package:hw1/data/dto/article_dto.dart';

abstract interface class NewsDao {
  Future<List<ArticleDto>> getNews();
}
