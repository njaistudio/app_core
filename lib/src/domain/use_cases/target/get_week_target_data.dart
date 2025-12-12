import 'package:app_core/app_core.dart';
import 'package:app_core/src/domain/entities/target_item.dart';
import 'package:app_core/src/domain/repositories/target_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetWeekTargetData implements UseCase<List<TargetItem>, NoParams> {
  GetWeekTargetData({required TargetRepository targetRepository}) : _targetRepository = targetRepository;

  final TargetRepository _targetRepository;

  @override
  Future<Either<Failure, List<TargetItem>>> call(NoParams params) async {
    final targetsResult = await _targetRepository.getWeekTargetData();
    return targetsResult.fold((l) => left(l), (targets) {
      final currentWeekDay = DateTime.now().weekday;
      targets.firstWhere((element) => element.weekDay == currentWeekDay).isHighlight = true;
      return Either.right(targets);
    });
  }
}
