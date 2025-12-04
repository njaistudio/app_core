import 'package:app_core/src/clean/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class StreamUserCase<Type, Params> {
  Stream<Either<Failure, Type>> call({Params params});
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}