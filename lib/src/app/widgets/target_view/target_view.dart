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
    required this.currentTarget,
    required this.onMenuTap,
    required this.currentStreak,
  });

  final List<TargetItem> targetItems;
  final int currentTarget;
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
                color: context.colorScheme.primaryFixed,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2).r,
                  child: Text(
                    "${CoreS.current.currentStreak}: $currentStreak",
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.surfaceTint,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            Bounceable(
              onTap: onMenuTap,
              child: CupertinoCard(
                elevation: 0,
                radius: BorderRadius.circular(10).r,
                margin: EdgeInsets.zero,
                color: context.colorScheme.primaryFixed,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2).r,
                  child: Text(
                    "$currentTarget ${CoreS.of(context).wordsPerDay}",
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.surfaceTint,
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
    final text = targetItem.score == 0 ? "-" : targetItem.score.toString();
    if(!targetItem.isHighlight) {
      return CupertinoCard(
        color: colorScheme.surface,
        radius: BorderRadius.circular(24).r,
        padding: const EdgeInsets.only(top: 4, bottom: 4).r,
        margin: const EdgeInsets.only(top: 8, right: 4, left: 4, bottom: 0).r,
        elevation: 0,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: LayoutBuilder(builder: (context, constraints) {
                return targetItem.completedPercent == 1 ? Icon(
                  CupertinoIcons.flame_fill,
                  color: colorScheme.tertiary.withAlpha(150),
                  size: constraints.maxHeight / 1.5,
                ) : CircularPercentIndicator(
                  radius: constraints.maxWidth / 3,
                  lineWidth: constraints.maxWidth / 13,
                  animation: true,
                  percent: targetItem.completedPercent,
                  center: Padding(
                    padding: const EdgeInsets.all(4.0).r,
                    child: AutoSizeText(
                      text,
                      style: context.textTheme.labelLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontSize: constraints.maxWidth / 4,
                      ),
                      maxLines: 1,
                      minFontSize: 5,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: colorScheme.onSecondary,
                  backgroundColor: colorScheme.onSecondary.withAlpha(50),
                );
              }),
            ),
            Text(
              targetItem.dayName,
              style: context.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 10.sp,
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }
    return CupertinoCard(
      color: colorScheme.primaryFixed,
      radius: BorderRadius.circular(24).r,
      padding: const EdgeInsets.only(top: 4, bottom: 4).r,
      margin: const EdgeInsets.only(top: 0, right: 4, left: 4, bottom: 0).r,
      elevation: 0.5,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(builder: (context, constraints) {
              return targetItem.completedPercent == 1 ? Icon(
                CupertinoIcons.flame_fill,
                color: colorScheme.surfaceTint,
                size: constraints.maxHeight / 1.5,
              ) : CircularPercentIndicator(
                radius: constraints.maxWidth / 3,
                lineWidth: constraints.maxWidth / 13,
                animation: true,
                percent: targetItem.completedPercent,
                center: Padding(
                  padding: const EdgeInsets.all(4.0).r,
                  child: AutoSizeText(
                    text,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: colorScheme.surfaceTint,
                      fontSize: constraints.maxWidth / 4,
                    ),
                    maxLines: 1,
                    minFontSize: 5,
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: colorScheme.surfaceTint,
                backgroundColor: colorScheme.surfaceTint.withAlpha(100),
              );
            }),
          ),
          Text(
            targetItem.dayName,
            style: context.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 10.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}