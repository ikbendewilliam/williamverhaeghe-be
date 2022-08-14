import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:williamverhaeghebe/screen/index.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'William Verhaeghe | Mobile Flutter developer, game dev and ML',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IndexScreen(),
    );
  }
}
