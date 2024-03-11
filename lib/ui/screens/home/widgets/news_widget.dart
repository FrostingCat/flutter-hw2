import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hw2/core/main_providers.dart';
import 'package:hw2/domain/entities/article_entity.dart';
import 'package:hw2/ui/screens/article/article_view.dart';

class NewsTile extends ConsumerWidget {
  final ArticleEntity article;
  final bool useLocalImage;

  const NewsTile(
      {required this.article, this.useLocalImage = false, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget newsImage = useLocalImage
        ? Image.file(
            File(article.urlToImage),
            height: 200,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          )
        : Image.network(
            article.urlToImage,
            height: 200,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          );

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      postUrl: article.articleUrl,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 1),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6), child: newsImage),
              const SizedBox(
                height: 12,
              ),
              Text(
                article.title,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                article.description,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: IconButton(
                    onPressed: () {
                      if (ref.read(newsProvider).contains(article)) {
                        ref.read(newsProvider.notifier).update((state) => state
                            .where((element) => element.title != article.title)
                            .toList());
                      } else {
                        ref
                            .read(newsProvider.notifier)
                            .update((state) => [...state, article]);
                      }
                    },
                    icon: ref
                            .watch<List<ArticleEntity>>(newsProvider)
                            .contains(article)
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
