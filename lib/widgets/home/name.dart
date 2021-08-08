import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';

class Name extends StatefulWidget {
  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<Color?>? _colorAnim;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 10), vsync: this);
    _colorAnim = RainbowColorTween([
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.red,
      Colors.blue,
    ]).animate(controller!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller
            ?..reset()
            ..forward();
        } else if (status == AnimationStatus.dismissed) {
          controller?.forward();
        }
      });
    controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'W',
            style: TextStyle(
              fontSize: 96,
              color: _colorAnim!.value ?? Colors.white,
            ),
          ),
          TextSpan(
            text: 'I',
            style: TextStyle(
              fontSize: 80,
              color: Colors.red,
            ),
          ),
          TextSpan(
            text: 'L',
            style: TextStyle(
              fontSize: 80,
              color: Colors.yellow[600],
            ),
          ),
          TextSpan(
            text: 'L',
            style: TextStyle(
              fontSize: 80,
              color: Colors.blue[600],
            ),
          ),
          TextSpan(
            text: 'I',
            style: TextStyle(
              fontSize: 80,
              color: Colors.green,
            ),
          ),
          TextSpan(
            text: 'A',
            style: TextStyle(
              fontSize: 80,
              color: Colors.red,
            ),
          ),
          TextSpan(
            text: 'M',
            style: TextStyle(
              fontSize: 80,
              color: Colors.yellow[600],
            ),
          ),
        ],
      ),
    );
  }
}
