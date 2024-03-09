import 'package:hw1/data/dao/news_dao.dart';
import 'package:hw1/data/dto/article_dto.dart';
import 'package:hw1/domain/entities/article_entity.dart';
import 'package:hw1/domain/mappers/article_mapper.dart';
import 'package:hw1/domain/repositories/news_repository.dart';
import 'package:hw1/domain/repositories/news_repository_impl.dart';
import 'package:test/test.dart';

final testArticles = [
  ArticleDto(
      title: 'Title',
      author: 'Description',
      description: 'Author',
      urlToImage: 'Content',
      publshedAt: DateTime(2024, 1, 1),
      content: 'UrlToImage',
      articleUrl: 'ArticleUrl')
];

class NewsDaoMock implements NewsDao {
  @override
  Future<List<ArticleDto>> getNews() async {
    return await Future(() => testArticles);
  }
}

void main() {
  test(
      'News repository should should return correct news stream with one article',
      () async {
    final NewsRepository newsRepository =
        NewsRepositoryImpl(NewsDaoMock(), ArticleMapper());

    final articles = await newsRepository.newsStream.first;
    expect(articles.length, 1);

    final article = articles[0];
    expect(article.title, 'Title');
    expect(article.author, 'Description');
    expect(article.description, 'Author');
    expect(article.urlToImage, 'Content');
    expect(article.publshedAt, DateTime(2024, 1, 1));
    expect(article.content, 'UrlToImage');
    expect(article.articleUrl, 'ArticleUrl');
  });

  test('News repository should fetch new articles', () async {
    final NewsRepository newsRepository =
        NewsRepositoryImpl(NewsDaoMock(), ArticleMapper());

    final oldArticles = await newsRepository.newsStream.first;
    expect(oldArticles.length, 1);

    testArticles.add(ArticleDto(
        title: 'Title2',
        author: 'Description2',
        description: 'Author2',
        urlToImage: 'Content2',
        publshedAt: DateTime(2024, 1, 2),
        content: 'UrlToImage2',
        articleUrl: 'ArticleUrl2'));

    await newsRepository.fetchNews();
    final newArticles = await newsRepository.newsStream.first;
    expect(newArticles.length, 2);
  });

}
