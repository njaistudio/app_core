import 'package:app_core/app_core.dart';
import 'package:fpdart/fpdart.dart';

class LinkAccountUseCase extends UseCase<User, NoParams> {
  final UserRepository userRepository;
  LinkAccountUseCase({required this.userRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return userRepository.linkAccount();
  }
}