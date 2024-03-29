import 'package:hw2/data/dto/article_dto.dart';
import 'package:hw2/domain/entities/article_entity.dart';

class ArticleMapper {
  ArticleEntity mapArticleDtoToEntity(ArticleDto dto) => ArticleEntity(
        title: dto.title,
        author: dto.author,
        description: dto.description,
        urlToImage: dto.urlToImage,
        publshedAt: dto.publshedAt,
        content: dto.content,
        articleUrl: dto.articleUrl,
      );
}
