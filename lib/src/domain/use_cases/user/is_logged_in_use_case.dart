import 'package:app_core/app_core.dart';

class IsLoggedInUseCase extends UseCase<bool, NoParams> {
  final UserRepository userRepository;
  IsLoggedInUseCase({required this.userRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final result = await userRepository.getUser();
    return result.fold((_) =>  Either.right(false), (_) => Either.right(true),);
  }
}