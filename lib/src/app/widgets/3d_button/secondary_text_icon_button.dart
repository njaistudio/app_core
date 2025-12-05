import 'package:app_core/app_core.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryTextIconButton extends StatefulWidget {
  const SecondaryTextIconButton({super.key, required this.onPressed, required this.text, this.textStyle, this.maxLines = 1, this.height = 50, required this.iconData});
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;
  final IconData iconData;
  final int maxLines;
  final double height;

  @override
  State<SecondaryTextIconButton> createState() {
    return _SecondaryTextIconButtonState();
  }
}

class _SecondaryTextIconButtonState extends State<SecondaryTextIconButton> {
  ColorScheme get _colorScheme => context.colorScheme;
  TextTheme get _textTheme => context.textTheme;

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      height: widget.height,
      onPressed: widget.onPressed,
      child: LayoutBuilder(
        builder: (context, size) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Icon(widget.iconData, size: size.maxHeight / 2, color: _colorScheme.onSurface),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.maxWidth - size.maxHeight),
                child: AutoSizeText(
                  widget.text,
                  maxLines: widget.maxLines,
                  style: widget.textStyle ?? _textTheme.titleLarge?.copyWith(
                    color: _colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: size.maxHeight / 2.5,
                  ),
                ),
              ),
            ],
          );
        }
    ),
    );
  }
}