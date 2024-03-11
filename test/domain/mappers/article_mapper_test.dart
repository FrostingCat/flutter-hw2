import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/data/dto/article_dto.dart';
import 'package:hw2/domain/mappers/article_mapper.dart';

void main() {
  test('mapArticleDtoToEntity should map required properties', () {
    final articleMapper = ArticleMapper();
    final articleDto = ArticleDto(
        title: 'title',
        description: 'description',
        author: 'author',
        content: 'content',
        publshedAt: DateTime(2024, 1, 1),
        urlToImage: 'urlToImage',
        articleUrl: 'articleUrl'
    );

    final articleEntity = articleMapper.mapArticleDtoToEntity(articleDto);

    expect(articleEntity.title, 'title');
    expect(articleEntity.description, 'description');
    expect(articleEntity.author, 'author');
    expect(articleEntity.content, 'content');
    expect(articleEntity.publshedAt, DateTime(2024, 1, 1));
    expect(articleEntity.urlToImage, 'urlToImage');
    expect(articleEntity.articleUrl, 'articleUrl');
  });
}
