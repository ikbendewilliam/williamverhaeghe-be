import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_morph/path_morph.dart';
import 'package:williamverhaeghebe/model/svg_paths.dart';

class Name extends StatefulWidget {
  final double height;

  const Name({
    this.height = 150,
    super.key,
  });

  @override
  NameState createState() => NameState();
}

class NameState extends State<Name> with TickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late final _williamPath = SvgPaths.william;
  late final _flutterPath = SvgPaths.flutter;
  late final _williamBounds = _williamPath.getBounds();
  late final _flutterBounds = _flutterPath.getBounds();
  late final _maxWidth = max(_williamBounds.width, _flutterBounds.width);
  late final _maxHeight = max(_williamBounds.height, _flutterBounds.height);
  final colorsWilliam = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.amber,
    Colors.pinkAccent,
    Colors.lime,
    Colors.indigo,
    Colors.black,
    Colors.purple,
    Colors.orange,
    Colors.teal,
  ];
  var colorWilliam = 0;
  final colorFlutter = Colors.blue;

  @override
  void initState() {
    super.initState();
    _controller.addStatusListener(_onControllerStatusChanged);
    _controller.forward();
  }

  void _onControllerStatusChanged(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      colorWilliam = (colorWilliam + 1) % colorsWilliam.length;
      await Future<void>.delayed(const Duration(seconds: 3));
      await _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      await Future<void>.delayed(const Duration(seconds: 3));
      await _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scaleW = constraints.maxWidth / _maxWidth / 1.5;
        final scaleH = widget.height / _maxHeight / 2;
        final scale = min(scaleW, scaleH);
        final williamMatrix = Matrix4.identity()
          ..scale(scale, scale, scale)
          ..translate(-_williamBounds.width / 2, _williamBounds.height, 0);
        final flutterMatrix = Matrix4.identity()
          ..scale(scale, scale, scale)
          ..translate(-_flutterBounds.width / 2, _flutterBounds.height, 0);
        final williamPath = Path.from(_williamPath).transform(williamMatrix.storage);
        final flutterPath = Path.from(_flutterPath).transform(flutterMatrix.storage);
        return Center(
          child: SizedBox(
            height: widget.height,
            child: MorphWidget(
              path1: williamPath,
              path2: flutterPath,
              controller: _controller,
              painter: (p0) => MorphPainter(
                p0,
                Paint()
                  ..style = PaintingStyle.fill
                  ..color = Color.lerp(colorsWilliam[colorWilliam], colorFlutter, _controller.value) ?? Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

class MorphPainter extends CustomPainter {
  final Path _path;
  final Paint _paint;

  MorphPainter(this._path, this._paint);

  @override
  void paint(Canvas canvas, Size size) => canvas.drawPath(_path, _paint);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
