import 'package:app_core/app_core.dart';
import 'package:fpdart/fpdart.dart';

class LinkAccountUseCase extends UseCase<Unit, AuthType> {
  final UserRepository userRepository;
  LinkAccountUseCase({required this.userRepository});

  @override
  Future<Either<Failure, Unit>> call(AuthType params) {
    return userRepository.linkAccount(params);
  }
}