import 'package:app_core/app_core.dart';
import 'package:app_core/src/domain/repositories/inapp_review_repository.dart';

class DisableReviewFunction implements UseCase<Unit, NoParams> {
  DisableReviewFunction({required this.inAppReviewRepository});

  final InAppReviewRepository inAppReviewRepository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return inAppReviewRepository.disableReviewFunction();
  }
}
