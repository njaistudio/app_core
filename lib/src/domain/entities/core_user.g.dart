// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserCWProxy {
  CoreUser id(String id);

  CoreUser email(String? email);

  CoreUser name(String? name);

  CoreUser avatar(String? avatar);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `User(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// User(...).copyWith(id: 12, name: "My name")
  /// ```
  CoreUser call({String id, String? email, String? name, String? avatar});
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfUser.copyWith(...)` or call `instanceOfUser.copyWith.fieldName(value)` for a single field.
class _$UserCWProxyImpl implements _$UserCWProxy {
  const _$UserCWProxyImpl(this._value);

  final CoreUser _value;

  @override
  CoreUser id(String id) => call(id: id);

  @override
  CoreUser email(String? email) => call(email: email);

  @override
  CoreUser name(String? name) => call(name: name);

  @override
  CoreUser avatar(String? avatar) => call(avatar: avatar);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `User(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// User(...).copyWith(id: 12, name: "My name")
  /// ```
  CoreUser call({
    Object? id = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? avatar = const $CopyWithPlaceholder(),
  }) {
    return CoreUser(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      avatar: avatar == const $CopyWithPlaceholder()
          ? _value.avatar
          // ignore: cast_nullable_to_non_nullable
          : avatar as String?,
    );
  }
}

extension $UserCopyWith on CoreUser {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfUser.copyWith(...)` or `instanceOfUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserCWProxy get copyWith => _$UserCWProxyImpl(this);
}
