import 'package:app_core/app_core.dart';

class LoginUseCase extends UseCase<CoreUser, AuthType> {
  final UserRepository userRepository;
  LoginUseCase({required this.userRepository});

  @override
  Future<Either<Failure, CoreUser>> call(AuthType params) {
    return userRepository.login(params);
  }
}