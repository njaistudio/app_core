import 'package:app_core/app_core.dart';
import 'package:app_core/src/domain/entities/target_item.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TargetView extends StatelessWidget {
  const TargetView({
    super.key,
    required this.targetItems,
    required this.onMenuTap,
    required this.currentStreak,
  });

  final List<TargetItem> targetItems;
  final int currentStreak;
  final GestureTapCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = DeviceHelper.isTablet(context) ? 64 : 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Bounceable(
              onTap: onMenuTap,
              child: CupertinoCard(
                elevation: 0,
                radius: BorderRadius.circular(10).r,
                margin: EdgeInsets.zero,
                color: context.colorScheme.surfaceContainerHigh,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2).r,
                  child: Text(
                    "${CoreS.current.currentStreak}: $currentStreak",
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h,),
        Padding(
          padding: EdgeInsets.only(left: horizontalPadding, right: horizontalPadding).r,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTargetItems(context),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTargetItems(
      BuildContext context,
      ) {
    List<Widget> items = [];
    for (var targetItem in targetItems) {
      items.add(Expanded(child: _buildTargetItem(context, targetItem)));
    }

    return items;
  }

  Widget _buildTargetItem(BuildContext context, TargetItem targetItem) {
    ColorScheme colorScheme = context.colorScheme;
    return CupertinoCard(
      color: targetItem.isHighlight ? colorScheme.surfaceContainerHighest : colorScheme.surfaceContainer,
      radius: BorderRadius.circular(24).r,
      padding: const EdgeInsets.only(top: 4, bottom: 4).r,
      margin: EdgeInsets.only(top: targetItem.isHighlight ? 0 : 8, right: 4, left: 4, bottom: 0).r,
      elevation: targetItem.isHighlight ? 0.5 : 0,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(builder: (context, constraints) {
              return TreeGrowthView(
                petalCount: targetItem.score,
                showNumber: false,
                size: constraints.maxHeight / 1.2,
                progressBackgroundColor: targetItem.isHighlight ? colorScheme.onPrimary.withAlpha(50) : colorScheme.surfaceContainerHigh,
              );
            }),
          ),
          Text(
            targetItem.dayName,
            style: context.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 10.sp,
              color: colorScheme.onSurface.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }
}