import 'package:flutter/material.dart';

class Hover extends StatefulWidget {
  final Widget? child;
  final Color? color;
  final Color? hoverColor;
  final double? borderRadius;
  final double? hoverBorderRadius;

  const Hover({
    Key? key,
    this.child,
    this.color,
    this.hoverColor,
    this.borderRadius,
    this.hoverBorderRadius,
  }) : super(key: key);

  @override
  HoverState createState() => HoverState();
}

class HoverState extends State<Hover> {
  final nonHoverTransform = Matrix4.identity()..translate(0, 0, 0);
  final hoverTransform = Matrix4.identity()..translate(0, -10, 0);

  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _hovering ? widget.hoverColor : widget.color,
          borderRadius: BorderRadius.circular(
            (_hovering ? widget.hoverBorderRadius : widget.borderRadius) ?? 0,
          ),
        ),
        child: widget.child,
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }
}
