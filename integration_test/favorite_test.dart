import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hw2/ui/screens/home/widgets/news_widget.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hw2/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'Should add favorites articles in favorite screen by tapping on button',
      (tester) async {
    app.main();
    await tester.pumpAndSettle();

    const newsTitle =
        "Apple reinstates Epic's developer account two days after banning it";
    final newsTileFinder = find.byKey(const ValueKey(newsTitle));
    final favoriteButtonFinder = find.descendant(
      of: newsTileFinder,
      matching: find.byType(IconButton),
    );

    expect(newsTileFinder, findsOneWidget);

    await tester.tap(favoriteButtonFinder);
    await tester.pump();

    final favoritesTab = find.byKey(const ValueKey('favorites_articles_tab'));

    await tester.tap(favoritesTab);
    await tester.pumpAndSettle();

    final favoriteNewsTileFinder = find.byType(NewsTile);

    expect(favoriteNewsTileFinder, findsOneWidget);

    final favoriteNewsFinder = find.descendant(
      of: favoriteNewsTileFinder,
      matching: find.text(newsTitle),
    );

    expect(favoriteNewsFinder, findsOneWidget);
  });

  testWidgets(
      'Should remove favorite article in favorite screen by tapping on button',
      (tester) async {
    app.main();
    await tester.pumpAndSettle();
    const articleTitle =
        "Apple reinstates Epic's developer account two days after banning it";
    final newsTileFinder = find.byKey(const ValueKey(articleTitle));
    final favoriteButtonFinder = find.descendant(
      of: newsTileFinder,
      matching: find.byType(IconButton),
    );

    await tester.tap(favoriteButtonFinder);
    await tester.pump();

    final favoritesTab = find.byKey(const ValueKey('favorites_articles_tab'));

    await tester.tap(favoritesTab);
    await tester.pumpAndSettle();

    final iconButton = find.byType(IconButton);

    await tester.tap(iconButton);
    await tester.pumpAndSettle();

    final favoriteNewsTileFinder = find.byType(NewsTile);

    expect(favoriteNewsTileFinder, findsNothing);
  });
}
