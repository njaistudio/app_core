import 'package:app_core/app_core.dart';

class DeleteUserUseCase extends UseCase<Unit, NoParams> {
  final UserRepository userRepository;
  DeleteUserUseCase({required this.userRepository});

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return userRepository.deleteUser();
  }
}