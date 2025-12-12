import 'package:app_core/app_core.dart';
import 'package:app_core/src/domain/repositories/target_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentTarget implements UseCase<int, NoParams> {
  GetCurrentTarget({required TargetRepository targetRepository}) : _targetRepository = targetRepository;

  final TargetRepository _targetRepository;

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return _targetRepository.getCurrentTarget();
  }
}
