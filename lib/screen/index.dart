import 'package:flutter/material.dart';
import 'package:williamverhaeghebe/widgets/home/button.dart';
import 'package:williamverhaeghebe/widgets/home/name.dart';
import 'package:williamverhaeghebe/widgets/home/skills.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              const Name(),
              const SizedBox(
                height: 400,
                child: Skills(),
              ),
              const SizedBox(height: 8),
              Button(
                text: 'Developers > GitHub',
                url: 'https://github.com/ikbendewilliam/',
                color: Colors.blue[600]!,
              ),
              Button(
                text: 'Android > Google Play',
                url: 'https://play.google.com/store/apps/collection/cluster?gsr=SjhqGFByTUFxQ1FRWTN5NkF1KzZ1bGpablE9PbICGwoZChViZS53aXZlLmN5Y2xpbmdlc2NhcGUQBw%3D%3D:S:ANO1ljIgvdY',
                color: Colors.green[600]!,
              ),
              Button(
                text: 'iOS > App store',
                url: 'https://apps.apple.com/us/developer/william-verhaeghe/id1553634304',
                color: Colors.cyan[600]!,
              ),
              const Button(
                text: 'Contact > LinkedIn',
                url: 'https://www.linkedin.com/in/william-verhaeghe/',
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
