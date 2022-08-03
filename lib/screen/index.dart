import 'package:flutter/material.dart';
import 'package:seo_renderer/seo_renderer.dart';
import 'package:williamverhaeghebe/widgets/home/button.dart';
import 'package:williamverhaeghebe/widgets/home/name.dart';

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Center(
              child: Name(),
            ),
            TextRenderer(
              style: TextRendererStyle.paragraph,
              child: Text(
                'William Verhaeghe is a Flutter mobile developer at icapps. He does some Mobile game development and Machine learning after hours.',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    Button(
                      text: 'Developers > GitHub',
                      url: 'https://github.com/ikbendewilliam/',
                      color: Colors.blue[600]!,
                    ),
                    Button(
                      text: 'Android Gamers > Google Play',
                      url:
                          'https://play.google.com/store/apps/collection/cluster?gsr=SjhqGFByTUFxQ1FRWTN5NkF1KzZ1bGpablE9PbICGwoZChViZS53aXZlLmN5Y2xpbmdlc2NhcGUQBw%3D%3D:S:ANO1ljIgvdY',
                      color: Colors.yellow[600]!,
                    ),
                    Button(
                      text: 'iOS Gamers > App store',
                      url: 'https://apps.apple.com/us/developer/william-verhaeghe/id1553634304',
                      color: Colors.cyan[600]!,
                    ),
                    Button(
                      text: 'Recruiters > LinkedIn',
                      url: 'https://www.linkedin.com/in/william-verhaeghe/',
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            TextRenderer(
              style: TextRendererStyle.header2,
              child: Text(
                'More info',
                textAlign: TextAlign.center,
              ),
            ),
            TextRenderer(
              style: TextRendererStyle.paragraph,
              child: Text(
                'If you want more information about William Verhaeghe, you can contact through linkedIn (use the button above).',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
