import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class SecondaryAnimateIconButton extends StatefulWidget {
  const SecondaryAnimateIconButton({super.key, required this.onPressed, required this.text, this.textStyle, this.maxLines = 1, this.height, required this.iconData});
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;
  final IconData iconData;
  final int maxLines;
  final double? height;

  @override
  State<SecondaryAnimateIconButton> createState() {
    return _SecondaryAnimateIconButtonState();
  }
}

class _SecondaryAnimateIconButtonState extends State<SecondaryAnimateIconButton> {
  ColorScheme get _colorScheme => context.colorScheme;
  TextTheme get _textTheme => context.textTheme;

  @override
  Widget build(BuildContext context) {
    final height = widget.height ?? 56.r;
    return SecondaryButton(
      height: height,
      onPressed: widget.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0).r,
              child: AutoSizeText(
                widget.text,
                maxLines: widget.maxLines,
                style: widget.textStyle ?? _textTheme.titleLarge?.copyWith(
                  color: _colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: height / 2.5,
                ),
              ),
            ),
          ),
          Icon(widget.iconData, size: height - 8.r, color: _colorScheme.onSurface,).animate().scale().then(duration: 500.ms).shake().then(duration: 500.ms).shake(),
        ],
      ),
    );
  }
}