import 'package:flutter/material.dart';
//import 'package:hw1/core/favorite_provider.dart';
import 'package:hw1/core/theme_provider.dart';
import 'package:hw1/ui/screens/home/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      //create: (context) => FavoriteProvider(),
      child: MaterialApp(
        title: 'News List',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
