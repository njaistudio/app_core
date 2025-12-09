import 'package:app_core/app_core.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.onPressed,
    this.height,
    required this.child,
    this.enabled = true,
    this.disableColor,
    this.disabledShadowColor,
    this.color,
    this.shadowColor,
  });

  final VoidCallback onPressed;
  final double? height;
  final Widget child;
  final bool enabled;
  final Color? disableColor;
  final Color? disabledShadowColor;
  final Color? color;
  final Color? shadowColor;

  @override
  State<SecondaryButton> createState() {
    return _SecondaryButtonState();
  }
}

class _SecondaryButtonState extends State<SecondaryButton> {
  ColorScheme get _colorScheme => context.colorScheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      height: widget.height ?? 56.r,
      borderWidth: 1,
      shadowHeight: 4,
      enabled: widget.enabled,
      color: widget.color ?? _colorScheme.surface,
      shadowColor: widget.shadowColor ?? _colorScheme.surfaceContainerHighest,
      disabledColor: widget.disableColor ?? _colorScheme.surface,
      disabledShadowColor: widget.disabledShadowColor ?? _colorScheme.surfaceContainerHighest,
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}