// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse data) success,
    required TResult Function(String error) error,
    required TResult Function() updating,
    required TResult Function(UpdateUserResponse data) updateSuccess,
    required TResult Function(String error) updateError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? updating,
    TResult? Function(UpdateUserResponse data)? updateSuccess,
    TResult? Function(String error)? updateError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse data)? success,
    TResult Function(String error)? error,
    TResult Function()? updating,
    TResult Function(UpdateUserResponse data)? updateSuccess,
    TResult Function(String error)? updateError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(ProfileSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(Updating<T> value) updating,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateError<T> value) updateError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(ProfileSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(Updating<T> value)? updating,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateError<T> value)? updateError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(ProfileSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(Updating<T> value)? updating,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateError<T> value)? updateError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<T, $Res> {
  factory $ProfileStateCopyWith(
          ProfileState<T> value, $Res Function(ProfileState<T>) then) =
      _$ProfileStateCopyWithImpl<T, $Res, ProfileState<T>>;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<T, $Res, $Val extends ProfileState<T>>
    implements $ProfileStateCopyWith<T, $Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<T, $Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl<T> value, $Res Function(_$InitialImpl<T>) then) =
      __$$InitialImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<T, $Res>
    extends _$ProfileStateCopyWithImpl<T, $Res, _$InitialImpl<T>>
    implements _$$InitialImplCopyWith<T, $Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl<T> _value, $Res Function(_$InitialImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl<T> implements _Initial<T> {
  const _$InitialImpl();

  @override
  String toString() {
    return 'ProfileState<$T>.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse data) success,
    required TResult Function(String error) error,
    required TResult Function() updating,
    required TResult Function(UpdateUserResponse data) updateSuccess,
    required TResult Function(String error) updateError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? updating,
    TResult? Function(UpdateUserResponse data)? updateSuccess,
    TResult? Function(String error)? updateError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse data)? success,
    TResult Function(String error)? error,
    TResult Function()? updating,
    TResult Function(UpdateUserResponse data)? updateSuccess,
    TResult Function(String error)? updateError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(ProfileSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(Updating<T> value) updating,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateError<T> value) updateError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(ProfileSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(Updating<T> value)? updating,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateError<T> value)? updateError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(ProfileSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(Updating<T> value)? updating,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateError<T> value)? updateError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial<T> implements ProfileState<T> {
  const factory _Initial() = _$InitialImpl<T>;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<T, $Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl<T> value, $Res Function(_$LoadingImpl<T>) then) =
      __$$LoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<T, $Res>
    extends _$ProfileStateCopyWithImpl<T, $Res, _$LoadingImpl<T>>
    implements _$$LoadingImplCopyWith<T, $Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl<T> _value, $Res Function(_$LoadingImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl<T> implements Loading<T> {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ProfileState<$T>.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse data) success,
    required TResult Function(String error) error,
    required TResult Function() updating,
    required TResult Function(UpdateUserResponse data) updateSuccess,
    required TResult Function(String error) updateError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? updating,
    TResult? Function(UpdateUserResponse data)? updateSuccess,
    TResult? Function(String error)? updateError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse data)? success,
    TResult Function(String error)? error,
    TResult Function()? updating,
    TResult Function(UpdateUserResponse data)? updateSuccess,
    TResult Function(String error)? updateError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(ProfileSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(Updating<T> value) updating,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateError<T> value) updateError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(ProfileSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(Updating<T> value)? updating,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateError<T> value)? updateError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(ProfileSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(Updating<T> value)? updating,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateError<T> value)? updateError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading<T> implements ProfileState<T> {
  const factory Loading() = _$LoadingImpl<T>;
}

/// @nodoc
abstract class _$$ProfileSuccessImplCopyWith<T, $Res> {
  factory _$$ProfileSuccessImplCopyWith(_$ProfileSuccessImpl<T> value,
          $Res Function(_$ProfileSuccessImpl<T>) then) =
      __$$ProfileSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({ProfileResponse data});
}

/// @nodoc
class __$$ProfileSuccessImplCopyWithImpl<T, $Res>
    extends _$ProfileStateCopyWithImpl<T, $Res, _$ProfileSuccessImpl<T>>
    implements _$$ProfileSuccessImplCopyWith<T, $Res> {
  __$$ProfileSuccessImplCopyWithImpl(_$ProfileSuccessImpl<T> _value,
      $Res Function(_$ProfileSuccessImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$ProfileSuccessImpl<T>(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ProfileResponse,
    ));
  }
}

/// @nodoc

class _$ProfileSuccessImpl<T> implements ProfileSuccess<T> {
  const _$ProfileSuccessImpl(this.data);

  @override
  final ProfileResponse data;

  @override
  String toString() {
    return 'ProfileState<$T>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileSuccessImpl<T> &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileSuccessImplCopyWith<T, _$ProfileSuccessImpl<T>> get copyWith =>
      __$$ProfileSuccessImplCopyWithImpl<T, _$ProfileSuccessImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse data) success,
    required TResult Function(String error) error,
    required TResult Function() updating,
    required TResult Function(UpdateUserResponse data) updateSuccess,
    required TResult Function(String error) updateError,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? updating,
    TResult? Function(UpdateUserResponse data)? updateSuccess,
    TResult? Function(String error)? updateError,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse data)? success,
    TResult Function(String error)? error,
    TResult Function()? updating,
    TResult Function(UpdateUserResponse data)? updateSuccess,
    TResult Function(String error)? updateError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(ProfileSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(Updating<T> value) updating,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateError<T> value) updateError,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(ProfileSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(Updating<T> value)? updating,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateError<T> value)? updateError,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(ProfileSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(Updating<T> value)? updating,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateError<T> value)? updateError,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ProfileSuccess<T> implements ProfileState<T> {
  const factory ProfileSuccess(final ProfileResponse data) =
      _$ProfileSuccessImpl<T>;

  ProfileResponse get data;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileSuccessImplCopyWith<T, _$ProfileSuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<T, $Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl<T> value, $Res Function(_$ErrorImpl<T>) then) =
      __$$ErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<T, $Res>
    extends _$ProfileStateCopyWithImpl<T, $Res, _$ErrorImpl<T>>
    implements _$$ErrorImplCopyWith<T, $Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl<T> _value, $Res Function(_$ErrorImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ErrorImpl<T>(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl<T> implements Error<T> {
  const _$ErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'ProfileState<$T>.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      __$$ErrorImplCopyWithImpl<T, _$ErrorImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse data) success,
    required TResult Function(String error) error,
    required TResult Function() updating,
    required TResult Function(UpdateUserResponse data) updateSuccess,
    required TResult Function(String error) updateError,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? updating,
    TResult? Function(UpdateUserResponse data)? updateSuccess,
    TResult? Function(String error)? updateError,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse data)? success,
    TResult Function(String error)? error,
    TResult Function()? updating,
    TResult Function(UpdateUserResponse data)? updateSuccess,
    TResult Function(String error)? updateError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(ProfileSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(Updating<T> value) updating,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateError<T> value) updateError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(ProfileSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(Updating<T> value)? updating,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateError<T> value)? updateError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(ProfileSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(Updating<T> value)? updating,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateError<T> value)? updateError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error<T> implements ProfileState<T> {
  const factory Error({required final String error}) = _$ErrorImpl<T>;

  String get error;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<T, _$ErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatingImplCopyWith<T, $Res> {
  factory _$$UpdatingImplCopyWith(
          _$UpdatingImpl<T> value, $Res Function(_$UpdatingImpl<T>) then) =
      __$$UpdatingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$UpdatingImplCopyWithImpl<T, $Res>
    extends _$ProfileStateCopyWithImpl<T, $Res, _$UpdatingImpl<T>>
    implements _$$UpdatingImplCopyWith<T, $Res> {
  __$$UpdatingImplCopyWithImpl(
      _$UpdatingImpl<T> _value, $Res Function(_$UpdatingImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UpdatingImpl<T> implements Updating<T> {
  const _$UpdatingImpl();

  @override
  String toString() {
    return 'ProfileState<$T>.updating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UpdatingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse data) success,
    required TResult Function(String error) error,
    required TResult Function() updating,
    required TResult Function(UpdateUserResponse data) updateSuccess,
    required TResult Function(String error) updateError,
  }) {
    return updating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? updating,
    TResult? Function(UpdateUserResponse data)? updateSuccess,
    TResult? Function(String error)? updateError,
  }) {
    return updating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse data)? success,
    TResult Function(String error)? error,
    TResult Function()? updating,
    TResult Function(UpdateUserResponse data)? updateSuccess,
    TResult Function(String error)? updateError,
    required TResult orElse(),
  }) {
    if (updating != null) {
      return updating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(ProfileSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(Updating<T> value) updating,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateError<T> value) updateError,
  }) {
    return updating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(ProfileSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(Updating<T> value)? updating,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateError<T> value)? updateError,
  }) {
    return updating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(ProfileSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(Updating<T> value)? updating,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateError<T> value)? updateError,
    required TResult orElse(),
  }) {
    if (updating != null) {
      return updating(this);
    }
    return orElse();
  }
}

abstract class Updating<T> implements ProfileState<T> {
  const factory Updating() = _$UpdatingImpl<T>;
}

/// @nodoc
abstract class _$$UpdateSuccessImplCopyWith<T, $Res> {
  factory _$$UpdateSuccessImplCopyWith(_$UpdateSuccessImpl<T> value,
          $Res Function(_$UpdateSuccessImpl<T>) then) =
      __$$UpdateSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({UpdateUserResponse data});
}

/// @nodoc
class __$$UpdateSuccessImplCopyWithImpl<T, $Res>
    extends _$ProfileStateCopyWithImpl<T, $Res, _$UpdateSuccessImpl<T>>
    implements _$$UpdateSuccessImplCopyWith<T, $Res> {
  __$$UpdateSuccessImplCopyWithImpl(_$UpdateSuccessImpl<T> _value,
      $Res Function(_$UpdateSuccessImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$UpdateSuccessImpl<T>(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as UpdateUserResponse,
    ));
  }
}

/// @nodoc

class _$UpdateSuccessImpl<T> implements UpdateSuccess<T> {
  const _$UpdateSuccessImpl(this.data);

  @override
  final UpdateUserResponse data;

  @override
  String toString() {
    return 'ProfileState<$T>.updateSuccess(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSuccessImpl<T> &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSuccessImplCopyWith<T, _$UpdateSuccessImpl<T>> get copyWith =>
      __$$UpdateSuccessImplCopyWithImpl<T, _$UpdateSuccessImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse data) success,
    required TResult Function(String error) error,
    required TResult Function() updating,
    required TResult Function(UpdateUserResponse data) updateSuccess,
    required TResult Function(String error) updateError,
  }) {
    return updateSuccess(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? updating,
    TResult? Function(UpdateUserResponse data)? updateSuccess,
    TResult? Function(String error)? updateError,
  }) {
    return updateSuccess?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse data)? success,
    TResult Function(String error)? error,
    TResult Function()? updating,
    TResult Function(UpdateUserResponse data)? updateSuccess,
    TResult Function(String error)? updateError,
    required TResult orElse(),
  }) {
    if (updateSuccess != null) {
      return updateSuccess(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(ProfileSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(Updating<T> value) updating,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateError<T> value) updateError,
  }) {
    return updateSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(ProfileSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(Updating<T> value)? updating,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateError<T> value)? updateError,
  }) {
    return updateSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(ProfileSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(Updating<T> value)? updating,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateError<T> value)? updateError,
    required TResult orElse(),
  }) {
    if (updateSuccess != null) {
      return updateSuccess(this);
    }
    return orElse();
  }
}

abstract class UpdateSuccess<T> implements ProfileState<T> {
  const factory UpdateSuccess(final UpdateUserResponse data) =
      _$UpdateSuccessImpl<T>;

  UpdateUserResponse get data;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateSuccessImplCopyWith<T, _$UpdateSuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateErrorImplCopyWith<T, $Res> {
  factory _$$UpdateErrorImplCopyWith(_$UpdateErrorImpl<T> value,
          $Res Function(_$UpdateErrorImpl<T>) then) =
      __$$UpdateErrorImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$UpdateErrorImplCopyWithImpl<T, $Res>
    extends _$ProfileStateCopyWithImpl<T, $Res, _$UpdateErrorImpl<T>>
    implements _$$UpdateErrorImplCopyWith<T, $Res> {
  __$$UpdateErrorImplCopyWithImpl(
      _$UpdateErrorImpl<T> _value, $Res Function(_$UpdateErrorImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$UpdateErrorImpl<T>(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateErrorImpl<T> implements UpdateError<T> {
  const _$UpdateErrorImpl({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'ProfileState<$T>.updateError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateErrorImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateErrorImplCopyWith<T, _$UpdateErrorImpl<T>> get copyWith =>
      __$$UpdateErrorImplCopyWithImpl<T, _$UpdateErrorImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(ProfileResponse data) success,
    required TResult Function(String error) error,
    required TResult Function() updating,
    required TResult Function(UpdateUserResponse data) updateSuccess,
    required TResult Function(String error) updateError,
  }) {
    return updateError(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(ProfileResponse data)? success,
    TResult? Function(String error)? error,
    TResult? Function()? updating,
    TResult? Function(UpdateUserResponse data)? updateSuccess,
    TResult? Function(String error)? updateError,
  }) {
    return updateError?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(ProfileResponse data)? success,
    TResult Function(String error)? error,
    TResult Function()? updating,
    TResult Function(UpdateUserResponse data)? updateSuccess,
    TResult Function(String error)? updateError,
    required TResult orElse(),
  }) {
    if (updateError != null) {
      return updateError(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial<T> value) initial,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(ProfileSuccess<T> value) success,
    required TResult Function(Error<T> value) error,
    required TResult Function(Updating<T> value) updating,
    required TResult Function(UpdateSuccess<T> value) updateSuccess,
    required TResult Function(UpdateError<T> value) updateError,
  }) {
    return updateError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial<T> value)? initial,
    TResult? Function(Loading<T> value)? loading,
    TResult? Function(ProfileSuccess<T> value)? success,
    TResult? Function(Error<T> value)? error,
    TResult? Function(Updating<T> value)? updating,
    TResult? Function(UpdateSuccess<T> value)? updateSuccess,
    TResult? Function(UpdateError<T> value)? updateError,
  }) {
    return updateError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial<T> value)? initial,
    TResult Function(Loading<T> value)? loading,
    TResult Function(ProfileSuccess<T> value)? success,
    TResult Function(Error<T> value)? error,
    TResult Function(Updating<T> value)? updating,
    TResult Function(UpdateSuccess<T> value)? updateSuccess,
    TResult Function(UpdateError<T> value)? updateError,
    required TResult orElse(),
  }) {
    if (updateError != null) {
      return updateError(this);
    }
    return orElse();
  }
}

abstract class UpdateError<T> implements ProfileState<T> {
  const factory UpdateError({required final String error}) =
      _$UpdateErrorImpl<T>;

  String get error;

  /// Create a copy of ProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateErrorImplCopyWith<T, _$UpdateErrorImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
