import 'package:app_core/app_core.dart';
import 'package:fpdart/fpdart.dart';

class GetUserUseCase extends UseCase<User, NoParams> {
  final UserRepository userRepository;
  GetUserUseCase({required this.userRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return userRepository.getUser();
  }
}