import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.maxLines = 1,
    this.color,
    this.shadowColor,
    required this.child,
    this.height,
    this.badge,
    this.badgeColor,
    this.enabled = true,
    this.shape = AnimatedButtonShape.rectangle,
  });
  final VoidCallback onPressed;
  final int maxLines;
  final Color? color;
  final Color? shadowColor;
  final Widget child;
  final double? height;
  final int? badge;
  final bool enabled;
  final Color? badgeColor;
  final AnimatedButtonShape shape;

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
      height: widget.height ?? 56.r,
      color: widget.color ?? _colorScheme.primary,
      shadowColor: widget.shadowColor ?? _colorScheme.primary.materialColor.shade700,
      disabledColor: _colorScheme.surfaceContainerHighest,
      disabledShadowColor: _colorScheme.surfaceContainer,
      onPressed: widget.onPressed,
      badge: widget.badge ?? 0,
      badgeColor: widget.badgeColor ?? Colors.red,
      enabled: widget.enabled,
      shape: widget.shape,
      shadowHeight: widget.shape == AnimatedButtonShape.circle ? 4 : 6,
      child: widget.child,
    );
  }
}