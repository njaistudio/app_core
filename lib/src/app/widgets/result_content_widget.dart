import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ResultContentWidget extends StatelessWidget {
  const ResultContentWidget({
    super.key,
    required this.score,
    required this.onPop
  });

  final int score;
  final VoidCallback onPop;

  @override
  Widget build(BuildContext context) {
    String title = "";
    String subtitle = "";
    if(score < 30) {
      title = CoreS.current.progress_less_30_title;
      subtitle = CoreS.current.progress_less_30_message(30 - score);
    } else if(score >= 30 && score < 45) {
      title = CoreS.current.progress_30_title;
      subtitle = CoreS.current.progress_30_message(45-score);
    } else if(score >= 45 && score < 60) {
      title = CoreS.current.progress_45_title;
      subtitle = CoreS.current.progress_45_message(60-score);
    } else if(score >= 60) {
      title = CoreS.current.progress_60_plus_title;
      subtitle = CoreS.current.progress_60_plus_message;
    }
    return Stack(
      children: [
        Lottie.asset('assets/success.json', package: "app_core"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.r,),
            TreeGrowthView(petalCount: score, size: 100.r,),
            SizedBox(height: 16.r,),
            Text(title, style: context.textTheme.headlineMedium?.copyWith(color: context.colorScheme.onSurface), textAlign: TextAlign.center,),
            SizedBox(height: 8.r,),
            Text(subtitle, style: context.textTheme.titleMedium?.copyWith(color: context.colorScheme.onSurface)),
            SizedBox(height: 16.r,),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8).r,
              child: DashLine(itemWidth: 8.r, space: 2.r, color: context.colorScheme.onSurface.withAlpha(100), itemHeight: 2.r,),
            ),
            SecondaryTextIconButton(
              height: 46.r,
              onPressed: () {
                Navigator.pop(context);
                onPop();
              },
              text: CoreS.current.done,
              iconData: Icons.check_rounded,
              contentColor: Colors.green.shade300,
            ),
          ],
        ),
      ],
    );
  }
}

class DashLine extends StatelessWidget {
  const DashLine({super.key, required this.itemWidth, required this.space, required this.color, required this.itemHeight});
  final double itemWidth;
  final double space;
  final Color color;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, size) {
          final itemNumber = (size.maxWidth / (itemWidth + space * 2)).toInt();
          List<Widget> items = [];
          for(var index = 0; index < itemNumber; index ++) {
            items.add(Padding(
              padding: EdgeInsets.only(left: space, right: space),
              child: Container(
                width: itemWidth,
                height: itemHeight,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(itemHeight),
                ),
              ),
            ));
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items,
          );
        }
    );
  }
}