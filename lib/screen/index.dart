import 'package:flutter/material.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_style.dart';
import 'package:seo_renderer/renderers/text_renderer/text_renderer_vm.dart';
import 'package:williamverhaeghebe/widgets/home/button.dart';
import 'package:williamverhaeghebe/widgets/home/name.dart';

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(child: Name()),
              TextRenderer(
                style: TextRendererStyle.paragraph,
                child: const Text(
                  'William Verhaeghe is a Flutter mobile developer at icapps. He does some Mobile game development and Machine learning after hours.',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Button(
                text: 'Developers > GitHub',
                url: 'https://github.com/ikbendewilliam/',
                color: Colors.blue[600]!,
              ),
              Button(
                text: 'Android Gamers > Google Play',
                url: 'https://play.google.com/store/apps/collection/cluster?gsr=SjhqGFByTUFxQ1FRWTN5NkF1KzZ1bGpablE9PbICGwoZChViZS53aXZlLmN5Y2xpbmdlc2NhcGUQBw%3D%3D:S:ANO1ljIgvdY',
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
              const SizedBox(height: 8),
              const TextRenderer(
                style: TextRendererStyle.header1,
                child: Text(
                  'More info',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const TextRenderer(
                style: TextRendererStyle.paragraph,
                child: Text(
                  'If you want more information about William Verhaeghe, you can contact him through linkedIn (use the button above).',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
