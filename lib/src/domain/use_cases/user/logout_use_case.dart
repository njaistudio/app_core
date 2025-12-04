import 'package:app_core/app_core.dart';
import 'package:fpdart/fpdart.dart';

class LogoutUseCase extends UseCase<Unit, NoParams> {
  final UserRepository userRepository;
  LogoutUseCase({required this.userRepository});

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return userRepository.logout();
  }
}