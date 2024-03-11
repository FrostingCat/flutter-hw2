import 'package:hw2/domain/entities/article_entity.dart';

abstract interface class NewsRepository {
  Stream<List<ArticleEntity>> get newsStream;
  Future<void> fetchNews();
}
