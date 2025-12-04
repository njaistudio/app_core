import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure(this.message);

  @override
  List<Object> get props => [message];
}

class UnknownError extends Failure {
  UnknownError(message) : super("Something went wrong.");
}

class NetWorkError extends Failure {
  NetWorkError(message) : super("NetWork Error.");
}