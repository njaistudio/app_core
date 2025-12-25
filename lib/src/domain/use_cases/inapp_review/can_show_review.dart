import 'package:app_core/app_core.dart';
import 'package:app_core/src/domain/repositories/inapp_review_repository.dart';

class CanShowReview implements UseCase<bool, NoParams> {
  CanShowReview({required this.inAppReviewRepository, required this.adInterstitial});

  final InAppReviewRepository inAppReviewRepository;
  final AdInterstitial adInterstitial;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    if(await adInterstitial.justShowAds()) return Either.right(false);
    return inAppReviewRepository.canShowReview();
  }
}
