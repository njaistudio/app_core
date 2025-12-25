import 'package:app_core/app_core.dart';

class IsAnonymousUseCase extends UseCase<bool, NoParams> {
  final UserRepository userRepository;
  IsAnonymousUseCase({required this.userRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final result = await userRepository.getUser();
    return result.fold((_) =>  Either.right(false), (user) => Either.right(user.isAnonymous),);
  }
}