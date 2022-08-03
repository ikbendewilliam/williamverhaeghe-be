import 'package:flutter/material.dart';
import 'package:seo_renderer/seo_renderer.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:williamverhaeghebe/screen/index.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RobotDetector(
      child: MaterialApp(
        title: 'William Verhaeghe | Mobile Flutter developer, game dev and ML',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: IndexScreen(),
        navigatorObservers: [seoRouteObserver],
      ),
    );
  }
}
