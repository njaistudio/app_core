import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class TreeGrowthCalendar extends StatelessWidget {
  const TreeGrowthCalendar({
    super.key,
    required this.treeGrowth,
  });

  final Map<int, int> treeGrowth;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.colorScheme;
    return CalendarCarousel(
      weekdayTextStyle: context.textTheme.titleMedium?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
      headerTextStyle: context.textTheme.titleLarge?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
      iconColor: colorScheme.onSurface,
      daysTextStyle: context.textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
      weekendTextStyle: context.textTheme.titleMedium?.copyWith(color: Colors.red.shade300, fontWeight: FontWeight.bold),
      firstDayOfWeek: 1,
      prevDaysTextStyle: context.textTheme.titleMedium?.copyWith(color: Colors.transparent),
      nextDaysTextStyle: context.textTheme.titleMedium?.copyWith(color: Colors.transparent),
      todayBorderColor: Colors.transparent,
      todayButtonColor: Colors.transparent,
      childAspectRatio: 0.6,
      isScrollable: false,
      customDayBuilder: (bool isSelectable, int index, bool isSelectedDay, bool isToday, bool isPrevMonthDay, TextStyle textStyle, bool isNextMonthDay, bool isThisMonthDay, DateTime day,) {
        if(!isThisMonthDay) return null;
        return CupertinoCard(
          color: isToday ? colorScheme.onSurface : colorScheme.surfaceContainer,
          radius: BorderRadius.circular(24).r,
          padding: const EdgeInsets.only(top: 4).r,
          margin: EdgeInsets.zero,
          elevation: isToday ? 0.5 : 0,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: TreeGrowthView(
                  petalCount: treeGrowth[day.day] ?? 0,
                  showNumber: false,
                  showProgress: isToday,
                  progressBackgroundColor: colorScheme.surfaceContainerLowest,
                ),
              ),
              SizedBox(height: 2.r,),
              Expanded(child: AutoSizeText(
                day.day.toString(),
                maxLines: 1,
                style: context.textTheme.titleMedium?.copyWith(
                  color: isToday ? colorScheme.surface : context.colorScheme.onSurface,
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}