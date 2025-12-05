import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({super.key, required this.onPressed, this.maxLines = 1, this.color, this.shadowColor, required this.child});
  final VoidCallback onPressed;
  final int maxLines;
  final Color? color;
  final Color? shadowColor;
  final Widget child;

  @override
  State<PrimaryButton> createState() {
    return _PrimaryButtonState();
  }
}

class _PrimaryButtonState extends State<PrimaryButton> {
  ColorScheme get _colorScheme => context.colorScheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      height: 56.r,
      color: widget.color ?? _colorScheme.onPrimaryFixedVariant,
      shadowColor: widget.shadowColor ?? _colorScheme.onPrimary,
      disabledColor: _colorScheme.surfaceContainerHighest,
      disabledShadowColor: _colorScheme.surfaceContainer,
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}