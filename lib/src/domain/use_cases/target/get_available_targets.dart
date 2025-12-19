
import 'package:app_core/app_core.dart';
import 'package:fpdart/fpdart.dart';

class GetAvailableTargets implements UseCase<List<int>, NoParams> {
  GetAvailableTargets({required TargetRepository targetRepository}) : _targetRepository = targetRepository;

  final TargetRepository _targetRepository;

  @override
  Future<Either<Failure, List<int>>> call(NoParams params) async {
    return _targetRepository.getAvailableTargets();
  }
}
