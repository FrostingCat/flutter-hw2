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

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //print(ref.watch<List<ArticleEntity>>(newsProvider));
    //final provider = FavoriteProvider.of(context);
    //final news = ref.watch<List<ArticleEntity>>(newsProvider);
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
                      final news = ref.watch(newsProvider);
                      if (news.contains(article)) {
                        news.remove(article);
                        ref.read(newsProvider.notifier).state = news;
                      } else {
                        news.add(article);
                        ref.read(newsProvider.notifier).state = news;
                      }
                    },
                    icon: ref.watch(newsProvider).contains(article)
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
