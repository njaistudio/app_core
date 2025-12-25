import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class PrimaryTextIconButton extends StatefulWidget {
  const PrimaryTextIconButton({super.key, required this.onPressed, required this.text, this.textStyle, this.maxLines = 1, this.height, required this.iconData, this.color, this.shadowColor, this.badge, this.badgeColor, this.enabled = true});
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;
  final IconData iconData;
  final int maxLines;
  final double? height;
  final Color? color;
  final Color? shadowColor;
  final int? badge;
  final Color? badgeColor;
  final bool enabled;

  @override
  State<PrimaryTextIconButton> createState() {
    return _PrimaryTextIconButtonState();
  }
}

class _PrimaryTextIconButtonState extends State<PrimaryTextIconButton> {
  ColorScheme get _colorScheme => context.colorScheme;
  TextTheme get _textTheme => context.textTheme;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      height: widget.height,
      onPressed: widget.onPressed,
      color: widget.color,
      shadowColor: widget.shadowColor,
      badge: widget.badge,
      badgeColor: widget.badgeColor,
      enabled: widget.enabled,
      child: LayoutBuilder(
        builder: (context, size) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.iconData, size: size.maxHeight / 1.7, color: _colorScheme.onPrimary),
              SizedBox(width: size.maxHeight / 15,),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.maxWidth - size.maxHeight),
                child: AutoSizeText(
                  widget.text,
                  maxLines: widget.maxLines,
                  style: widget.textStyle ?? _textTheme.titleLarge?.copyWith(
                    color: _colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: size.maxHeight / 2.2,
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