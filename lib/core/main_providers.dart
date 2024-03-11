import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hw2/data/dao/news_dao.dart';
import 'package:hw2/data/dao/news_runtime_dao.dart';
import 'package:hw2/domain/entities/article_entity.dart';
import 'package:hw2/domain/mappers/article_mapper.dart';
import 'package:hw2/domain/repositories/news_repository.dart';
import 'package:hw2/domain/repositories/news_repository_impl.dart';

final newsDaoProvider = Provider<NewsDao>(
  (ref) => NewsRuntimeDao(),
);

final newsMapperProvider = Provider<ArticleMapper>(
  (ref) => ArticleMapper(),
);

final newsRepositoryProvider = Provider<NewsRepository>(
  (ref) => NewsRepositoryImpl(
    ref.read(newsDaoProvider),
    ref.read(newsMapperProvider),
  ),
);

List<ArticleEntity> _news = [];

final newsProvider = StateProvider<List<ArticleEntity>>(
  (ref) => _news
  );