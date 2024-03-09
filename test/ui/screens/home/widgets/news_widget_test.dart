import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw1/core/main_providers.dart';
import 'package:hw1/domain/entities/article_entity.dart';
import 'package:hw1/ui/screens/home/widgets/news_widget.dart';

const imgUrl = 'url';
const desc = 'desc';
const title = 'title';
const content = 'content';
const posturl = 'posturl';
final article = ArticleEntity(
      title: 'Title',
      author: 'Description',
      description: 'Author',
      urlToImage: 'Content',
      publshedAt: DateTime(2024, 1, 1),
      content: 'UrlToImage',
      articleUrl: 'ArticleUrl');
final articles = [article];

void main() {
  testWidgets('news widget ...', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          newsProvider.overrideWith(articles);
        ],
      ),
    );
    
    await tester.pumpWidget(NewsTile(
        imgUrl: imgUrl,
        desc: desc,
        title: title,
        content: content,
        posturl: posturl,
        article: article));
  

  expect(find.byIcon(Icons.favorite), findsOneWidget);
  expect(find.byIcon(Icons.favorite_border), findsNothing);

  await tester.tap(find.byIcon(Icons.favorite));
  await tester.pump();

  expect(find.byIcon(Icons.favorite), findsNothing);
  expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });
}
