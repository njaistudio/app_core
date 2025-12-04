import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum ResultBackgroundStatus {
  none, correct, wrong
}

class ResultBackgroundController {
  Function(ResultBackgroundStatus)? start;

  ResultBackgroundController({this.start});
}

class ResultBackground extends StatefulWidget {
  const ResultBackground({super.key, required  this.controller, required this.child});
  final ResultBackgroundController controller;
  final Widget child;

  @override
  State<ResultBackground> createState() {
    return _ResultBackgroundState();
  }
}

class _ResultBackgroundState extends State<ResultBackground> with AnimationMixin {
  late Animation<double> _opacity;
  ResultBackgroundStatus _status = ResultBackgroundStatus.none;

  @override
  void initState() {
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
    widget.controller.start = (status) {
      setState(() {
        _status = status;
      });
      controller.reset();
      controller.play(duration: const Duration(milliseconds: 500));
    };
    super.initState();
  }

  Color get _backgroundColor {
    switch(_status) {
      case ResultBackgroundStatus.none:
        return Colors.transparent;
      case ResultBackgroundStatus.correct:
        return Colors.green;
      case ResultBackgroundStatus.wrong:
        return Colors.red;
    }
  }

  @override
  void dispose() {
    if(!controller.isCompleted) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: _opacity.value,
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [_backgroundColor.withValues(alpha: 0.3), _backgroundColor.withValues(alpha: 0.2)],
                stops: const [0, 1],
                center: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}