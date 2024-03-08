import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hw1/core/main_providers.dart';
import 'package:hw1/domain/entities/article_entity.dart';
import 'package:hw1/domain/repositories/news_repository.dart';
import 'package:hw1/ui/screens/home/widgets/news_widget.dart';
import 'package:hw1/core/favorite_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, _) => _HomeView(
        newsRepository: ref.watch(newsRepositoryProvider),
      ),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  final NewsRepository newsRepository;

  const _HomeView({
    required this.newsRepository,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final list = 
    // final provider = FavoriteProvider.of(context);
    final links = ref.watch<List<ArticleEntity>>(newsProvider);
    //print(ref.watch<List<ArticleEntity>>(newsProvider));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('News'),
              Text(
                'List',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
          elevation: 0.5,
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.anchor_sharp),
            ),
            Tab(icon: Icon(Icons.favorite))
          ]),
        ),
        body: StreamBuilder(
          stream: widget.newsRepository.newsStream,
          builder: (context, snapshot) {
            final articles = snapshot.data;

            final bodyWidget = switch (articles) {
              null when snapshot.hasError => Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Error loading data'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: widget.newsRepository.fetchNews,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              null => const Center(
                  child: CircularProgressIndicator(),
                ),
              _ => TabBarView(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.builder(
                                itemCount: articles.length,
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return NewsTile(
                                      imgUrl: articles[index].urlToImage,
                                      title: articles[index].title,
                                      desc: articles[index].description,
                                      content: articles[index].content,
                                      posturl: articles[index].articleUrl,
                                      article: articles[index]);
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Theme.of(context).primaryColor,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                  itemCount: links.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return NewsTile(
                                        imgUrl: links[index].urlToImage,
                                        title: links[index].title,
                                        desc: links[index].description,
                                        content: links[index].content,
                                        posturl: links[index].articleUrl,
                                        article: links[index]);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
            };
            return bodyWidget;
          },
        ),
      ),
    );
  }
}