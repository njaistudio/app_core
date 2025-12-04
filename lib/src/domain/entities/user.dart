import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'user.g.dart';

@CopyWith()
class User extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? avatar;

  User({
    required this.id,
    this.email,
    this.name,
    this.avatar,
  });

  bool get isAnonymous => email == null || email!.isEmpty;

  @override
  List<Object?> get props => [id, email, name, avatar];
}