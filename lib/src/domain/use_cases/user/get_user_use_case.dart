import 'package:app_core/app_core.dart';

class GetUserUseCase extends UseCase<CoreUser, NoParams> {
  final UserRepository userRepository;
  GetUserUseCase({required this.userRepository});

  @override
  Future<Either<Failure, CoreUser>> call(NoParams params) {
    return userRepository.getUser();
  }
}