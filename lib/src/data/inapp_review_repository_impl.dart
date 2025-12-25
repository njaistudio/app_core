import 'package:app_core/app_core.dart';
import 'package:app_core/src/domain/repositories/inapp_review_repository.dart';

class InAppReviewRepositoryImpl implements InAppReviewRepository {
  final CoreSharedPreferencesHelper sharedPreferencesHelper;

  InAppReviewRepositoryImpl({
    required this.sharedPreferencesHelper,
  });

  @override
  Future<Either<Failure,bool>> canShowReview() async {
    final reviewCount = await sharedPreferencesHelper.reviewCount();
    return Either.right(reviewCount >= 3 && reviewCount < 200);
  }

  @override
  Future<Either<Failure,Unit>> disableReviewFunction() async {
    await sharedPreferencesHelper.setReviewCount(200);
    return Either.right(unit);
  }

  @override
  Future<Either<Failure,Unit>> increaseReviewCount() async {
    final reviewCount = await sharedPreferencesHelper.reviewCount();
    await sharedPreferencesHelper.setReviewCount(reviewCount + 1);
    return Either.right(unit);
  }
}
