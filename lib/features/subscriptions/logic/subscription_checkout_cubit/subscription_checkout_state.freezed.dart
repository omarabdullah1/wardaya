// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_checkout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SubscriptionCheckoutState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String recipientName, String phoneNumber)
        recipientSelected,
    required TResult Function(LatLng location, String address, String area)
        locationSelected,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area)?
        locationSelected,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area)?
        locationSelected,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_RecipientSelected value) recipientSelected,
    required TResult Function(_LocationSelected value) locationSelected,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionCheckoutStateCopyWith<$Res> {
  factory $SubscriptionCheckoutStateCopyWith(SubscriptionCheckoutState value,
          $Res Function(SubscriptionCheckoutState) then) =
      _$SubscriptionCheckoutStateCopyWithImpl<$Res, SubscriptionCheckoutState>;
}

/// @nodoc
class _$SubscriptionCheckoutStateCopyWithImpl<$Res,
        $Val extends SubscriptionCheckoutState>
    implements $SubscriptionCheckoutStateCopyWith<$Res> {
  _$SubscriptionCheckoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionCheckoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SubscriptionCheckoutStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionCheckoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SubscriptionCheckoutState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String recipientName, String phoneNumber)
        recipientSelected,
    required TResult Function(LatLng location, String address, String area)
        locationSelected,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area)?
        locationSelected,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area)?
        locationSelected,
    TResult Function(String message)? error,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_RecipientSelected value) recipientSelected,
    required TResult Function(_LocationSelected value) locationSelected,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SubscriptionCheckoutState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$RecipientSelectedImplCopyWith<$Res> {
  factory _$$RecipientSelectedImplCopyWith(_$RecipientSelectedImpl value,
          $Res Function(_$RecipientSelectedImpl) then) =
      __$$RecipientSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String recipientName, String phoneNumber});
}

/// @nodoc
class __$$RecipientSelectedImplCopyWithImpl<$Res>
    extends _$SubscriptionCheckoutStateCopyWithImpl<$Res,
        _$RecipientSelectedImpl>
    implements _$$RecipientSelectedImplCopyWith<$Res> {
  __$$RecipientSelectedImplCopyWithImpl(_$RecipientSelectedImpl _value,
      $Res Function(_$RecipientSelectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionCheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipientName = null,
    Object? phoneNumber = null,
  }) {
    return _then(_$RecipientSelectedImpl(
      recipientName: null == recipientName
          ? _value.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RecipientSelectedImpl implements _RecipientSelected {
  const _$RecipientSelectedImpl(
      {required this.recipientName, required this.phoneNumber});

  @override
  final String recipientName;
  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'SubscriptionCheckoutState.recipientSelected(recipientName: $recipientName, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipientSelectedImpl &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recipientName, phoneNumber);

  /// Create a copy of SubscriptionCheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipientSelectedImplCopyWith<_$RecipientSelectedImpl> get copyWith =>
      __$$RecipientSelectedImplCopyWithImpl<_$RecipientSelectedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String recipientName, String phoneNumber)
        recipientSelected,
    required TResult Function(LatLng location, String address, String area)
        locationSelected,
    required TResult Function(String message) error,
  }) {
    return recipientSelected(recipientName, phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area)?
        locationSelected,
    TResult? Function(String message)? error,
  }) {
    return recipientSelected?.call(recipientName, phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area)?
        locationSelected,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (recipientSelected != null) {
      return recipientSelected(recipientName, phoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_RecipientSelected value) recipientSelected,
    required TResult Function(_LocationSelected value) locationSelected,
    required TResult Function(_Error value) error,
  }) {
    return recipientSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(_Error value)? error,
  }) {
    return recipientSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (recipientSelected != null) {
      return recipientSelected(this);
    }
    return orElse();
  }
}

abstract class _RecipientSelected implements SubscriptionCheckoutState {
  const factory _RecipientSelected(
      {required final String recipientName,
      required final String phoneNumber}) = _$RecipientSelectedImpl;

  String get recipientName;
  String get phoneNumber;

  /// Create a copy of SubscriptionCheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipientSelectedImplCopyWith<_$RecipientSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocationSelectedImplCopyWith<$Res> {
  factory _$$LocationSelectedImplCopyWith(_$LocationSelectedImpl value,
          $Res Function(_$LocationSelectedImpl) then) =
      __$$LocationSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LatLng location, String address, String area});
}

/// @nodoc
class __$$LocationSelectedImplCopyWithImpl<$Res>
    extends _$SubscriptionCheckoutStateCopyWithImpl<$Res,
        _$LocationSelectedImpl>
    implements _$$LocationSelectedImplCopyWith<$Res> {
  __$$LocationSelectedImplCopyWithImpl(_$LocationSelectedImpl _value,
      $Res Function(_$LocationSelectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionCheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? address = null,
    Object? area = null,
  }) {
    return _then(_$LocationSelectedImpl(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      area: null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LocationSelectedImpl implements _LocationSelected {
  const _$LocationSelectedImpl(
      {required this.location, required this.address, required this.area});

  @override
  final LatLng location;
  @override
  final String address;
  @override
  final String area;

  @override
  String toString() {
    return 'SubscriptionCheckoutState.locationSelected(location: $location, address: $address, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationSelectedImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.area, area) || other.area == area));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location, address, area);

  /// Create a copy of SubscriptionCheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationSelectedImplCopyWith<_$LocationSelectedImpl> get copyWith =>
      __$$LocationSelectedImplCopyWithImpl<_$LocationSelectedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String recipientName, String phoneNumber)
        recipientSelected,
    required TResult Function(LatLng location, String address, String area)
        locationSelected,
    required TResult Function(String message) error,
  }) {
    return locationSelected(location, address, area);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area)?
        locationSelected,
    TResult? Function(String message)? error,
  }) {
    return locationSelected?.call(location, address, area);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area)?
        locationSelected,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (locationSelected != null) {
      return locationSelected(location, address, area);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_RecipientSelected value) recipientSelected,
    required TResult Function(_LocationSelected value) locationSelected,
    required TResult Function(_Error value) error,
  }) {
    return locationSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(_Error value)? error,
  }) {
    return locationSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (locationSelected != null) {
      return locationSelected(this);
    }
    return orElse();
  }
}

abstract class _LocationSelected implements SubscriptionCheckoutState {
  const factory _LocationSelected(
      {required final LatLng location,
      required final String address,
      required final String area}) = _$LocationSelectedImpl;

  LatLng get location;
  String get address;
  String get area;

  /// Create a copy of SubscriptionCheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationSelectedImplCopyWith<_$LocationSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$SubscriptionCheckoutStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionCheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'SubscriptionCheckoutState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SubscriptionCheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String recipientName, String phoneNumber)
        recipientSelected,
    required TResult Function(LatLng location, String address, String area)
        locationSelected,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area)?
        locationSelected,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area)?
        locationSelected,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_RecipientSelected value) recipientSelected,
    required TResult Function(_LocationSelected value) locationSelected,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements SubscriptionCheckoutState {
  const factory _Error({required final String message}) = _$ErrorImpl;

  String get message;

  /// Create a copy of SubscriptionCheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
