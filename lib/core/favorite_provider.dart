import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hw1/domain/entities/article_entity.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends StateNotifier<List<ArticleEntity>> {
  FavoriteProvider(state) : super(state ?? []);

  List<ArticleEntity> _news = [];
  List<ArticleEntity> get news => _news;

  void toggleFavorite(ArticleEntity news) {
    final isExist = _news.contains(news);
    if (isExist) {
      state = [ ...state, news];
    } else {
     state = state.where((ArticleEntity newss) => newss != news).toList();
    }
  }

  bool isExist(ArticleEntity news) {
    final isExist = _news.contains(news);
    return isExist;
  }

  void clearFavorite() {
    _news = [];
  }
}

class ContainerListState extends StateNotifier<List<ArticleEntity>> {
  ContainerListState() : super(const []);
  // No static provider declaration in here
}
// Provider moved out here
final containerListProvider = StateNotifierProvider<ContainerListState, List<ArticleEntity>>((ref) {
  return ContainerListState();
});