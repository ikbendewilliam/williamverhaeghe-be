import 'package:flutter/material.dart';
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
            Text('Flutter developer @icapps with Mobile game dev and ML on the side'),
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
                      text: 'Recruiters > LinkedIn',
                      url: 'https://www.linkedin.com/in/william-verhaeghe/',
                      color: Colors.red,
                    ),
                    Button(
                      text: 'icapps',
                      url: 'https://icapps.com/',
                      color: Colors.green,
                    ),
                    Button(
                      text: 'Mail',
                      url: 'mailto:work@williamverhaeghe.be',
                      color: Colors.yellow[600]!,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
