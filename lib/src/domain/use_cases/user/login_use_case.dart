import 'package:app_core/app_core.dart';
import 'package:fpdart/fpdart.dart';

class LoginUseCase extends UseCase<User, AuthType> {
  final UserRepository userRepository;
  LoginUseCase({required this.userRepository});

  @override
  Future<Either<Failure, User>> call(AuthType params) {
    return userRepository.login(params);
  }
}