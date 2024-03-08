// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hw1/domain/entities/article_entity.dart';
// import 'package:provider/provider.dart';

// class FavoriteProvider extends ChangeNotifier {
//   List<ArticleEntity> _news = [];
//   List<ArticleEntity> get news => _news;

//   void toggleFavorite(ArticleEntity news) {
//     final isExist = _news.contains(news);
//     if (isExist) {
//       _news.remove(news);
//     } else {
//       _news.add(news);
//     }
//     notifyListeners();
//   }

//   bool isExist(ArticleEntity news) {
//     final isExist = _news.contains(news);
//     return isExist;
//   }

//   void clearFavorite() {
//     _news = [];
//     notifyListeners();
//   }

//   static FavoriteProvider of(
//     BuildContext context, {
//     bool listen = true,
//   }) {
//     return Provider.of<FavoriteProvider>(
//       context,
//       listen: listen,
//     );
//   }
// }

// class ContainerListState extends StateNotifier<List<ArticleEntity>> {
//   ContainerListState() : super(const []);
//   // No static provider declaration in here
// }
// // Provider moved out here
// final containerListProvider = StateNotifierProvider<ContainerListState, List<ArticleEntity>>((ref) {
//   return ContainerListState();
// });