import 'dart:math';

import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class _ShakeTween extends Tween<double> {
  final double intensity;
  _ShakeTween({this.intensity = 0.2}) : super(begin: 0.0, end: 0.0);

  @override
  double transform(double t) {
    return sin(t * pi * 4) * intensity;
  }
}

class _HorizontalShakeTween extends Tween<double> {
  final double distance;
  _HorizontalShakeTween({this.distance = 8.0}) : super(begin: 0.0, end: 0.0);

  @override
  double transform(double t) {
    double shakeDirection = sin(t * pi * 20);
    return shakeDirection * distance * (1 - t);
  }
}

enum _QuestionButtonStatus {
  correct,
  wrong,
  none,
}

class QuestionButton extends StatefulWidget {
  const QuestionButton({super.key, this.height, required this.isCorrectAnswer, required this.onPress, this.onAnimationEnd, required this.child});
  final double? height;
  final bool isCorrectAnswer;
  final VoidCallback onPress;
  final VoidCallback? onAnimationEnd;
  final Widget child;

  @override
  State<QuestionButton> createState() {
    return _QuestionButtonState();
  }
}

class _QuestionButtonState extends State<QuestionButton> {
  Control _animationControl = Control.stop;
  _QuestionButtonStatus _state = _QuestionButtonStatus.none;

  MovieTween get _correctShakeTween {
    final tween = MovieTween();
    tween.scene(
      begin: Duration.zero,
      end: const Duration(milliseconds: 200),
    ).tween('scale', Tween(begin: 0.0, end: 1.0), curve: Curves.easeOutBack);
    tween.scene(
      begin: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 500),
    ).tween(
      'rotation',
      _ShakeTween(intensity: 0.2),
      curve: Curves.linear,
    );
    tween.scene(
      begin: const Duration(milliseconds: 700),
      duration: const Duration(milliseconds: 200),
    ).tween('scale', Tween(begin: 1.0, end: 0.0), curve: Curves.easeInBack);

    return tween;
  }

  MovieTween get _wrongShakeTween {
    final tween = MovieTween();
    tween.scene(
      begin: Duration.zero,
      end: const Duration(milliseconds: 200),
    ).tween('scale', Tween(begin: 0.0, end: 1.0), curve: Curves.easeOutBack);
    tween.scene(
      begin: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 500),
    ).tween(
      'translateX',
      _HorizontalShakeTween(distance: 6.0),
      curve: Curves.linear,
    );
    tween.scene(
      begin: const Duration(milliseconds: 700),
      duration: const Duration(milliseconds: 200),
    ).tween('scale', Tween(begin: 1.0, end: 0.0), curve: Curves.easeInBack);

    return tween;
  }

  double get _randomOffset => - Random().nextInt(20).toDouble();

  ColorScheme get _colorScheme => ColorScheme.of(context);

  void _trigger() async {
    setState(() {
      _animationControl = Control.playFromStart;
      _state = widget.isCorrectAnswer ? _QuestionButtonStatus.correct : _QuestionButtonStatus.wrong;
    });
    await Future.delayed(Duration(seconds: 1));
    _animationControl = Control.stop;
    widget.onAnimationEnd?.call();
  }

  List<Widget> _buildCorrectCorners(Control currentControl, BoxConstraints parentSize) {
    final positions = [
      {'top': - _randomOffset, 'left': - _randomOffset * 2},
      {'top': - _randomOffset, 'right': - _randomOffset * 2},
      {'bottom': - _randomOffset, 'left': - _randomOffset * 2},
      {'bottom': - _randomOffset, 'right': - _randomOffset * 2},
    ];

    return positions.map((pos) {
      return Positioned(
        top: pos['top'],
        bottom: pos['bottom'],
        left: pos['left'],
        right: pos['right'],
        child: CustomAnimationBuilder<Movie>(
          control: currentControl,
          tween: _correctShakeTween,
          duration: _correctShakeTween.duration,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value.get('scale'),
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: value.get('rotation') ?? 0.0,
                alignment: Alignment.center,
                child: Blob.random(
                  size: parentSize.maxHeight / 4,
                  edgesCount: 5,
                  minGrowth: 9,
                  styles: BlobStyles(
                    color: Colors.green.shade300,
                  ),
                  child: Icon(Icons.check_rounded, size: parentSize.maxHeight / 8, color: Colors.white, fontWeight: FontWeight.bold,),
                ),
              ),
            );
          },
        ),
      );
    }).toList();
  }

  List<Widget> _buildWrongCorners(Control currentControl, BoxConstraints parentSize) {
    final positions = [
      {'top': - _randomOffset, 'left': - _randomOffset},
      {'top': - _randomOffset, 'right': - _randomOffset},
      {'bottom': - _randomOffset, 'left': - _randomOffset},
      {'bottom': - _randomOffset, 'right': - _randomOffset},
    ];

    return positions.map((pos) {
      return Positioned(
        top: pos['top'],
        bottom: pos['bottom'],
        left: pos['left'],
        right: pos['right'],
        child: CustomAnimationBuilder<Movie>(
          key: ValueKey(currentControl),
          control: currentControl,
          tween: _wrongShakeTween,
          duration: _wrongShakeTween.duration,
          builder: (context, value, child) {
            final double scale = value.get('scale');
            final double translateX = value.get('translateX') ?? 0.0;
            return Transform.scale(
              scale: scale,
              child: Transform.translate(
                offset: Offset(translateX, 0.0),
                child: Blob.random(
                  size: parentSize.maxHeight / 4,
                  edgesCount: 5,
                  minGrowth: 9,
                  styles: BlobStyles(
                    color: Colors.red.shade300,
                  ),
                  child: Icon(Icons.clear_rounded, size: parentSize.maxHeight / 8, color: Colors.white, fontWeight: FontWeight.bold,),
                ),
              ),
            );
          },
        ),
      );
    }).toList();
  }

  Color get _shadowColor {
    switch(_state) {
      case _QuestionButtonStatus.correct:
        return Colors.green.shade300;
      case _QuestionButtonStatus.wrong:
        return Colors.red.shade300;
      case _QuestionButtonStatus.none:
        return _colorScheme.surfaceContainerHighest;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedButton(
              color: _colorScheme.surface,
              shadowColor: _shadowColor,
              height: size.maxHeight,
              borderWidth: _state == _QuestionButtonStatus.none ? 1 : 1.2,
              shadowHeight: _state == _QuestionButtonStatus.none ? 3 : 1.2,
              enabled: _state == _QuestionButtonStatus.none,
              disabledColor: _colorScheme.surface,
              disabledShadowColor: _shadowColor,
              child: widget.child,
              onPressed: () {
                widget.onPress.call();
                _trigger();
              },
            ),
            ... _state == _QuestionButtonStatus.correct ? _buildCorrectCorners(_animationControl, size) : _buildWrongCorners(_animationControl, size),
          ],
        );
      }
    );
  }
}