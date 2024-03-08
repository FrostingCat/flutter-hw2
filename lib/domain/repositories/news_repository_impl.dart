import 'package:hw1/data/dao/news_dao.dart';
import 'package:hw1/domain/entities/article_entity.dart';
import 'package:hw1/domain/mappers/article_mapper.dart';
import 'package:hw1/domain/repositories/news_repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsDao _newsDao;
  final ArticleMapper _mapper;

  NewsRepositoryImpl(this._newsDao, this._mapper);

  late final BehaviorSubject<List<ArticleEntity>> _newsSubject =
      BehaviorSubject(
    onListen: () async {
      await _fetchNewsIfNeeded();
    },
  );

  @override
  Stream<List<ArticleEntity>> get newsStream =>
      _newsSubject.map((habitsMap) => habitsMap);

  @override
  Future<void> fetchNews() async {
    await _fetchNewsIfNeeded(forceFetch: true);
  }

  Future<void> _fetchNewsIfNeeded({
    bool forceFetch = false,
  }) async {
    if (_newsSubject.hasValue && !forceFetch) {
      return;
    }

    final newsDto = await _newsDao.getNews();
    final articlesList = newsDto.map((dto) {
      final newsEntity = _mapper.mapArticleDtoToEntity(dto);
      return newsEntity;
    });
    _newsSubject.add(articlesList.toList());
  }
}