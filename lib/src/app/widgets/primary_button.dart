import 'package:app_core/app_core.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({super.key, required this.onPressed, required this.text, this.textStyle, this.maxLines = 1});
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;
  final int maxLines;

  @override
  State<PrimaryButton> createState() {
    return _PrimaryButtonState();
  }
}

class _PrimaryButtonState extends State<PrimaryButton> {
  ColorScheme get _colorScheme => context.colorScheme;
  TextTheme get _textTheme => context.textTheme;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      height: 56.r,
      color: _colorScheme.onPrimaryFixedVariant,
      shadowColor: _colorScheme.onPrimary,
      disabledColor: _colorScheme.surfaceContainerHighest,
      disabledShadowColor: _colorScheme.surfaceContainer,
      onPressed: widget.onPressed,
      child: AutoSizeText(
        widget.text,
        style: widget.textStyle ?? _textTheme.titleLarge?.copyWith(
          color: _colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}