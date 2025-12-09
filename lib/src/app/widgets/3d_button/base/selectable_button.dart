import 'package:app_core/app_core.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectableButton extends StatefulWidget {
  const SelectableButton({
    super.key,
    required this.onPressed,
    this.height,
    required this.child,
    this.selected = false,
    this.selectedColor,
    this.selectedShadowColor,
    this.color,
    this.shadowColor,
  });

  final VoidCallback onPressed;
  final double? height;
  final Widget child;
  final bool selected;
  final Color? color;
  final Color? shadowColor;
  final Color? selectedColor;
  final Color? selectedShadowColor;

  @override
  State<SelectableButton> createState() {
    return _SelectableButtonState();
  }
}

class _SelectableButtonState extends State<SelectableButton> {
  ColorScheme get _colorScheme => context.colorScheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      height: widget.height ?? 56.r,
      borderWidth: 1,
      shadowHeight: widget.selected ? 1 : 3,
      enabled: !widget.selected,
      color: widget.color ?? _colorScheme.surface,
      shadowColor: widget.shadowColor ?? _colorScheme.surfaceContainerHighest,
      disabledColor: widget.selectedColor ?? _colorScheme.surface,
      disabledShadowColor: widget.selectedShadowColor ?? _colorScheme.primaryFixedDim,
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}