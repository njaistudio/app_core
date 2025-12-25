import 'package:app_core/generated/l10n.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class UnknownError extends Failure {
   UnknownError() : super(CoreS.current.somethingWentWrong);
}

class NetWorkError extends Failure {
  NetWorkError() : super(CoreS.current.netWorkError);
}