import 'package:app_core/src/domain/use_cases/inapp_review/can_show_review.dart';
import 'package:app_core/src/domain/use_cases/inapp_review/disable_review_function.dart';
import 'package:app_core/src/domain/use_cases/inapp_review/increase_review_count.dart';

class InAppReviewUseCases {
  final CanShowReview canShowReview;
  final DisableReviewFunction disableReviewFunction;
  final IncreaseReviewCount increaseReviewCount;

  InAppReviewUseCases({
    required this.canShowReview,
    required this.disableReviewFunction,
    required this.increaseReviewCount,
  });
}
