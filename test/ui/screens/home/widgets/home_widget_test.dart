import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/domain/entities/article_entity.dart';
import 'package:hw2/ui/screens/home/widgets/news_widget.dart';

void main() {
  testWidgets('News widget should show article', (tester) async {
    final article = ArticleEntity(
        title: 'ArticleTitle',
        description: 'ArticleDescription',
        author: 'ArticleAuthor',
        content: 'ArticleContent',
        publshedAt: DateTime(2024, 1, 1),
        urlToImage: 'web/images/test.jpg',
        articleUrl: 'ArticleArticleUrl');

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ProviderScope(
                child: NewsTile(article: article, useLocalImage: true)))));

    final titleFinder = find.text('ArticleTitle');
    final descriptionFinder = find.text('ArticleDescription');

    expect(titleFinder, findsOneWidget);
    expect(descriptionFinder, findsOneWidget);
  });

  testWidgets('News widget button should change favorite image after tapping',
      (tester) async {
    final article = ArticleEntity(
        title: 'ArticleTitle',
        description: 'desc',
        author: 'ArticleAuthor',
        content: 'ArticleContent',
        publshedAt: DateTime(2024, 1, 1),
        urlToImage: 'web/images/test.jpg',
        articleUrl: 'ArticleArticleUrl');

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ProviderScope(
                child: NewsTile(article: article, useLocalImage: true)))));

    final favoriteButtonFinder = find.byType(IconButton);
    final favoriteBorderIcon = tester.widget<Icon>(find.descendant(
      of: favoriteButtonFinder,
      matching: find.byType(Icon),
    ));

    expect(favoriteBorderIcon.icon, equals(Icons.favorite_border));

    await tester.tap(favoriteButtonFinder);
    await tester.pump();

    final favoriteIcon = tester.widget<Icon>(find.descendant(
      of: favoriteButtonFinder,
      matching: find.byType(Icon),
    ));

    expect(favoriteIcon.icon, equals(Icons.favorite));
  });
}
