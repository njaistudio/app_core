import 'package:app_core/src/cupertino_rounded_corners.dart';
import 'package:app_core/src/exts.dart';
import 'package:app_core/src/learn_progress.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LearnStatusView extends StatelessWidget {
  const LearnStatusView({super.key, required this.learnProgress, this.margin = EdgeInsets.zero});
  final LearnProgress learnProgress;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final learnStatus = learnProgress.learnStatus;
    switch (learnStatus) {
      case LearnStatus.notLearned:
        return Container();
      case LearnStatus.learnAndWaitingReview:
        return _buildLearnedView(context);
      case LearnStatus.needReviewNow:
        return _buildWaitingReviewView(context);
      case LearnStatus.master:
        return _buildMasterView(context);
      case LearnStatus.skipped:
        return _buildSkipView(context);
    }
  }

  Widget _buildSkipView(BuildContext context) {
    return CupertinoCard(
      elevation: 0,
      radius: BorderRadius.circular(8.r),
      padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 1.r),
      margin: margin,
      color: learnProgress.learnStatusColor.shade300,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.tornado,
            color: context.colorScheme.onSecondary,
            size: 8.sp,
          ),
          SizedBox(width: 1.r,),
          AutoSizeText(
            learnProgress.getLearnStatusString(context),
            style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 8.r
            ),
            maxLines: 1,
            minFontSize: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildMasterView(BuildContext context) {
    return CupertinoCard(
      elevation: 0,
      radius: BorderRadius.circular(8.r),
      padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 1.r),
      margin: margin,
      color: learnProgress.learnStatusColor.shade400,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.flame_fill,
            color: context.colorScheme.onSecondary,
            size: 8.sp,
          ),
          SizedBox(width: 1.r,),
          AutoSizeText(
            learnProgress.getLearnStatusString(context),
            style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 8.r
            ),
            maxLines: 1,
            minFontSize: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildLearnedView(BuildContext context) {
    return CupertinoCard(
      elevation: 0,
      radius: BorderRadius.circular(8.r),
      padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 1.r),
      margin: margin,
      color: learnProgress.learnStatusColor.shade400,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.flame_fill,
            color: context.colorScheme.onSecondary,
            size: 8.sp,
          ),
          SizedBox(width: 1.r,),
          AutoSizeText(
            learnProgress.getLearnStatusString(context),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 8.r
            ),
            maxLines: 1,
            minFontSize: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildWaitingReviewView(BuildContext context) {
    return CupertinoCard(
      elevation: 0,
      radius: BorderRadius.circular(8.r),
      padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 1.r),
      margin: margin,
      color: learnProgress.learnStatusColor.shade300,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.fitness_center_rounded,
            color: context.colorScheme.onSecondary,
            size: 8.sp,
          ),
          SizedBox(width: 1.r,),
          AutoSizeText(
            learnProgress.getLearnStatusString(context),
            style: context.textTheme.labelSmall?.copyWith(
              color: context.colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 8.r
            ),
            maxLines: 1,
            minFontSize: 5,
          ),
        ],
      ),
    );
  }
}