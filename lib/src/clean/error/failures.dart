import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class UnknownError extends Failure {
  const UnknownError(String message) : super("Something went wrong.");
}

class NetWorkError extends Failure {
  const NetWorkError(String message) : super("NetWork Error.");
}