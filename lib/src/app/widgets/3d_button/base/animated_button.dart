import 'package:flutter/material.dart';

import '../../cupertino_rounded_corners.dart';

/// Using [ShadowDegree] with values [ShadowDegree.dark] or [ShadowDegree.light]
/// to get a darker version of the used color.
/// [duration] in milliseconds
///
class AnimatedButton extends StatefulWidget {
  final Color color;
  final Color shadowColor;
  final Color disabledColor;
  final Color disabledShadowColor;
  final Widget child;
  final bool enabled;
  final int duration;
  final double height;
  final double shadowHeight;
  final double borderWidth;
  final VoidCallback onPressed;

  const AnimatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.height = 60,
    this.duration = 70,
    this.enabled = true,
    this.borderWidth = 0,
    this.shadowHeight = 6,
    required this.color,
    required this.shadowColor,
    required this.disabledColor,
    required this.disabledShadowColor,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  static const Curve _curve = Curves.easeIn;
  double _shadowHeight = 0;
  double _position = 0;

  @override
  void initState() {
    _shadowHeight = widget.shadowHeight;
    _position = _shadowHeight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_shadowHeight != widget.shadowHeight) {
      _shadowHeight = widget.shadowHeight;
      _position = _shadowHeight;
    }

    final double height = widget.height - _shadowHeight;

    return LayoutBuilder(
      builder: (context, size) {
        return GestureDetector(
          onTapDown: widget.enabled ? _pressed : null,
          onTapUp: widget.enabled ? _unPressedOnTapUp : null,
          onTapCancel: widget.enabled ? _unPressed : null,
          child: SizedBox(
            width: size.maxWidth,
            height: height + _shadowHeight,
            child: Stack(
              children: <Widget>[
                // background shadow serves as drop shadow
                // width is necessary for bottom shadow
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: height,
                    width: size.maxWidth,
                    decoration: ShapeDecoration(
                      color: widget.enabled ? widget.shadowColor : widget.disabledShadowColor,
                      shape: _getBorderRadius(),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  curve: _curve,
                  duration: Duration(milliseconds: widget.duration),
                  bottom: _position,
                  child: Container(
                    padding: EdgeInsets.all(widget.borderWidth),
                    height: height,
                    width: size.maxWidth,
                    decoration: ShapeDecoration(
                      color:widget.enabled ? widget.shadowColor : widget.disabledShadowColor,
                      shape: _getBorderRadius(),
                    ),
                    child: Container(
                      height: height,
                      width: size.maxWidth,
                      decoration: ShapeDecoration(
                        color: widget.enabled ? widget.color : widget.disabledColor,
                        shape: _getBorderRadius(),
                      ),
                      child: Center(child: widget.child),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  void _pressed(_) {
    setState(() {
      _position = 0;
    });
  }

  void _unPressedOnTapUp(_) => _unPressed();

  void _unPressed() async {
    setState(() {
      _position = _shadowHeight;
    });
    await Future.delayed(Duration(milliseconds: widget.duration));
    widget.onPressed();
  }

  SquircleBorder _getBorderRadius() {
    return SquircleBorder(
      radius: BorderRadius.all(
        Radius.circular(
          widget.height / 2.2,
        ),
      ),
    );
  }
}
