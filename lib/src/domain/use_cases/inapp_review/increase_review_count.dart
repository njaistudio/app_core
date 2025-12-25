import 'package:app_core/app_core.dart';
import 'package:app_core/src/domain/repositories/inapp_review_repository.dart';

class IncreaseReviewCount implements UseCase<Unit, NoParams> {
  IncreaseReviewCount({required this.inAppReviewRepository});

  final InAppReviewRepository inAppReviewRepository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return inAppReviewRepository.increaseReviewCount();
  }
}
