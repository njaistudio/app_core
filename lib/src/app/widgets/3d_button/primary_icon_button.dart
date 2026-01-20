import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryIconButton extends StatelessWidget {
  const PrimaryIconButton({
    super.key,
    required this.onPressed,
    this.color,
    this.iconColor,
    this.shadowColor,
    this.size,
    required this.iconData,
    this.isActive = true,
    this.shape = AnimatedButtonShape.circle,
  });
  final VoidCallback onPressed;
  final Color? color;
  final Color? shadowColor;
  final double? size;
  final Color? iconColor;
  final IconData iconData;
  final bool isActive;
  final AnimatedButtonShape shape;

  @override
  Widget build(BuildContext context) {
    final notNullSize = size ?? 56.r;
    final realIconColor = isActive ? (iconColor ?? context.colorScheme.onPrimary) : context.colorScheme.surfaceContainer;
    return SizedBox(
      width: notNullSize,
      height: notNullSize,
      child: PrimaryButton(
        onPressed: onPressed,
        color: isActive ? color : context.colorScheme.surfaceContainerHighest,
        shadowColor: isActive ? shadowColor : context.colorScheme.surfaceContainer,
        height: notNullSize,
        shape: shape,
        child: Icon(iconData, color: realIconColor, size: notNullSize / 1.7),
      ),
    );
  }
}
