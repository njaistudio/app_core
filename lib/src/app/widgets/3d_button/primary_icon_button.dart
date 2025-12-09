import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryIconButton extends StatelessWidget {
  const PrimaryIconButton({super.key, required this.onPressed, this.color, this.shadowColor, this.size, required this.iconData, this.enabled = true});
  final VoidCallback onPressed;
  final Color? color;
  final Color? shadowColor;
  final double? size;
  final IconData iconData;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final notNullSize = size ?? 56.r;
    return SizedBox(
      width: notNullSize,
      height: notNullSize,
      child: PrimaryButton(
        onPressed: onPressed,
        color: color,
        shadowColor: shadowColor,
        height: notNullSize,
        enabled: enabled,
        child: Icon(iconData, color: context.colorScheme.onPrimary, size: notNullSize / 1.7),
      ),
    );
  }
}
