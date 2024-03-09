import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hw1/core/main_providers.dart';
import 'package:hw1/domain/entities/article_entity.dart';
import 'package:hw1/core/favorite_provider.dart';
import 'package:hw1/ui/screens/article/article_view.dart';

class NewsTile extends ConsumerWidget {
  final String imgUrl, title, desc, content, posturl;
  final ArticleEntity article;

  const NewsTile(
      {required this.imgUrl,
      required this.desc,
      required this.title,
      required this.content,
      required this.posturl,
      required this.article,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      postUrl: posturl,
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
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    imgUrl,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                height: 12,
              ),
              Text(
                title,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                desc,
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
