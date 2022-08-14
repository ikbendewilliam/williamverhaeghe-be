import 'dart:math';

import 'package:flutter/material.dart';
import 'package:williamverhaeghebe/model/skill.dart';

final skills = [
  Skill(
    name: 'Flutter',
    value: 0.9,
    color: Colors.blue,
  ),
  Skill(
    name: 'Animations',
    value: 0.8,
    color: Colors.lime,
  ),
  Skill(
    name: 'ML',
    value: 0.65,
    color: Colors.red,
  ),
  Skill(
    name: 'Game Dev',
    value: 0.6,
    color: Colors.green,
  ),
  Skill(
    name: 'K3 lyrics',
    value: 0.9,
    color: Colors.pink[300]!,
  ),
  Skill(
    name: 'Love for dogs',
    value: 1,
    color: Colors.purple,
  ),
];
const singleAnimationDuration = 500;
const singleAnimationDelay = 200;
const animationDuration = 3000;
const resetAfterAnimations = 5;

class Skills extends StatefulWidget {
  const Skills({super.key});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> with TickerProviderStateMixin {
  var _initialAnimation = true;
  var _animations = 0;
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: animationDuration),
  )
    ..forward()
    ..addStatusListener(_animationStatusListener);

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animations++;
      if (_animations < resetAfterAnimations) {
        if (_initialAnimation) {
          setState(() {
            _initialAnimation = false;
          });
        }
      } else {
        setState(() {
          _initialAnimation = true;
          _animations = 0;
        });
      }
      _animationController
        ..reset()
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Stack(
          children: [
            ...skills.asMap().entries.map((e) => _gradient(context, e.value, e.key)),
            if (!_initialAnimation) ...[
              Container(
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.lighten,
                  gradient: RadialGradient(
                    radius: _animationController.value,
                    colors: [
                      Colors.transparent,
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                    ],
                    stops: const [
                      0.6,
                      0.8,
                      1,
                    ],
                  ),
                ),
              ),
            ],
            ...skills.asMap().entries.map(
                  (e) => Center(
                    child: Builder(
                      builder: (context) {
                        final angle = (e.key + 0.5) / skills.length * pi * 2;
                        final radius = 180 * e.value.value * _calculateProgress(e.key) + 20;
                        if (radius <= 0) return const SizedBox();
                        return Transform(
                          transform: Matrix4.identity()..translate(radius * 1.2 * sin(angle), -radius * cos(angle)),
                          child: Text(
                            '${e.value.name} ${e.value.value * 100}%',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: e.value.color,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  double _calculateProgress(int index) {
    var progress = _initialAnimation ? (_animationController.value * animationDuration - index * singleAnimationDelay) / singleAnimationDuration : 9999.0;
    if (progress > 1) progress = 1;
    if (progress > 0.9) return 1.8 - progress;
    return progress;
  }

  Widget _gradient(BuildContext context, Skill skill, int index) {
    final progress = _calculateProgress(index);
    if (progress <= 0) return const SizedBox();
    final radius = progress * skill.value;
    return ClipPath(
      clipper: _Clipper(index, radius),
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: radius * 0.5,
            colors: [
              Colors.transparent,
              skill.color.withOpacity(0.5),
              skill.color,
            ],
            stops: const [
              0,
              0.95,
              1,
            ],
          ),
        ),
      ),
    );
  }
}

class _Clipper extends CustomClipper<Path> {
  final int _index;
  final double _scale;

  _Clipper(this._index, this._scale);

  @override
  Path getClip(Size size) {
    final radius = min(size.width, size.height) / 2 * _scale;
    final center = Offset(size.width, size.height) / 2;
    final angle = _index / skills.length * pi * 2 - pi / 2;
    final path = Path();
    path.moveTo(center.dx, center.dy);
    path.lineTo(center.dx + radius * cos(angle), center.dy + radius * sin(angle));
    path.arcTo(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      angle,
      1 / skills.length * pi * 2,
      false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
