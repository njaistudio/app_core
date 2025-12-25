import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class SecondaryIconButton extends StatelessWidget {
  const SecondaryIconButton({
    super.key,
    required this.onPressed,
    this.color,
    this.shadowColor,
    this.size,
    this.iconColor,
    required this.iconData,
    this.isActive = true,
    this.shape = AnimatedButtonShape.circle,
  });
  final VoidCallback onPressed;
  final Color? color;
  final Color? shadowColor;
  final Color? iconColor;
  final double? size;
  final IconData iconData;
  final AnimatedButtonShape shape;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final notNullSize = size ?? 56.r;
    final realIconColor = isActive ? (iconColor ?? context.colorScheme.onSurface) : context.colorScheme.surfaceContainerHigh;
    return SizedBox(
      width: notNullSize,
      height: notNullSize,
      child: SecondaryButton(
        onPressed: onPressed,
        color: isActive ? color : context.colorScheme.surface,
        shadowColor: isActive ? shadowColor : context.colorScheme.surfaceContainerHigh,
        height: notNullSize,
        shape: shape,
        child: Icon(iconData, color: realIconColor, size: notNullSize / 1.7),
      ),
    );
  }
}
