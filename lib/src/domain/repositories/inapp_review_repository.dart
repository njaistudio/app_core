import 'package:app_core/app_core.dart';

abstract class InAppReviewRepository {
  Future<Either<Failure,bool>> canShowReview();

  Future<Either<Failure,Unit>> disableReviewFunction();

  Future<Either<Failure,Unit>> increaseReviewCount();
}