import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:hw2/data/dto/article_dto.dart';
import 'package:hw2/data/dao/news_dao.dart';

class NewsRuntimeDao implements NewsDao {
  @override
  Future<List<ArticleDto>> getNews() async {
    List<ArticleDto> news = [];

    String url =
        'https://newsapi.org/v2/everything?q=apple&from=2024-03-07&to=2024-03-14&sortBy=popularity&apiKey=d072211f628249d0960d277c69f480a6';

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleDto article = ArticleDto(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element['content'],
            articleUrl: element['url'],
          );
          news.add(article);
        }
      });
    }
    return news;
  }
}
