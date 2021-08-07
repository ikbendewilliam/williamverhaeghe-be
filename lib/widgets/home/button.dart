import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:williamverhaeghebe/widgets/home/hover.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class Button extends StatelessWidget {
  final String url;
  final String text;
  final Color color;

  const Button({
    Key? key,
    required this.url,
    required this.text,
    required this.color,
  }) : super(key: key);

  void _launch() => js.context.callMethod('open', [url, url.startsWith('http') ? '_blank' : '_self']);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          width: 256,
          child: Hover(
            child: GestureDetector(
              onTap: _launch,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            color: color,
            hoverColor: Colors.black,
            borderRadius: 0,
            hoverBorderRadius: 16,
          ),
        ),
      ),
    );
  }
}
