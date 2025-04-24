// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CheckoutState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String recipientName, String phoneNumber)
        recipientSelected,
    required TResult Function(
            LatLng location, String address, String area, String additionalInfo)
        locationSelected,
    required TResult Function() loading,
    required TResult Function(CheckoutResponse response) loaded,
    required TResult Function(String message) error,
    required TResult Function(String date, DateTime dateTime)
        deliveryTimeSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult? Function()? loading,
    TResult? Function(CheckoutResponse response)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String date, DateTime dateTime)? deliveryTimeSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult Function()? loading,
    TResult Function(CheckoutResponse response)? loaded,
    TResult Function(String message)? error,
    TResult Function(String date, DateTime dateTime)? deliveryTimeSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_RecipientSelected value) recipientSelected,
    required TResult Function(_LocationSelected value) locationSelected,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_DeliveryTimeSelected value) deliveryTimeSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckoutStateCopyWith<$Res> {
  factory $CheckoutStateCopyWith(
          CheckoutState value, $Res Function(CheckoutState) then) =
      _$CheckoutStateCopyWithImpl<$Res, CheckoutState>;
}

/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res, $Val extends CheckoutState>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CheckoutState
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
    extends _$CheckoutStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'CheckoutState.initial()';
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
    required TResult Function(
            LatLng location, String address, String area, String additionalInfo)
        locationSelected,
    required TResult Function() loading,
    required TResult Function(CheckoutResponse response) loaded,
    required TResult Function(String message) error,
    required TResult Function(String date, DateTime dateTime)
        deliveryTimeSelected,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult? Function()? loading,
    TResult? Function(CheckoutResponse response)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String date, DateTime dateTime)? deliveryTimeSelected,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult Function()? loading,
    TResult Function(CheckoutResponse response)? loaded,
    TResult Function(String message)? error,
    TResult Function(String date, DateTime dateTime)? deliveryTimeSelected,
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
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_DeliveryTimeSelected value) deliveryTimeSelected,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CheckoutState {
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
    extends _$CheckoutStateCopyWithImpl<$Res, _$RecipientSelectedImpl>
    implements _$$RecipientSelectedImplCopyWith<$Res> {
  __$$RecipientSelectedImplCopyWithImpl(_$RecipientSelectedImpl _value,
      $Res Function(_$RecipientSelectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckoutState
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
    return 'CheckoutState.recipientSelected(recipientName: $recipientName, phoneNumber: $phoneNumber)';
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

  /// Create a copy of CheckoutState
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
    required TResult Function(
            LatLng location, String address, String area, String additionalInfo)
        locationSelected,
    required TResult Function() loading,
    required TResult Function(CheckoutResponse response) loaded,
    required TResult Function(String message) error,
    required TResult Function(String date, DateTime dateTime)
        deliveryTimeSelected,
  }) {
    return recipientSelected(recipientName, phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult? Function()? loading,
    TResult? Function(CheckoutResponse response)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String date, DateTime dateTime)? deliveryTimeSelected,
  }) {
    return recipientSelected?.call(recipientName, phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult Function()? loading,
    TResult Function(CheckoutResponse response)? loaded,
    TResult Function(String message)? error,
    TResult Function(String date, DateTime dateTime)? deliveryTimeSelected,
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
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_DeliveryTimeSelected value) deliveryTimeSelected,
  }) {
    return recipientSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
  }) {
    return recipientSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
    required TResult orElse(),
  }) {
    if (recipientSelected != null) {
      return recipientSelected(this);
    }
    return orElse();
  }
}

abstract class _RecipientSelected implements CheckoutState {
  const factory _RecipientSelected(
      {required final String recipientName,
      required final String phoneNumber}) = _$RecipientSelectedImpl;

  String get recipientName;
  String get phoneNumber;

  /// Create a copy of CheckoutState
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
  $Res call(
      {LatLng location, String address, String area, String additionalInfo});
}

/// @nodoc
class __$$LocationSelectedImplCopyWithImpl<$Res>
    extends _$CheckoutStateCopyWithImpl<$Res, _$LocationSelectedImpl>
    implements _$$LocationSelectedImplCopyWith<$Res> {
  __$$LocationSelectedImplCopyWithImpl(_$LocationSelectedImpl _value,
      $Res Function(_$LocationSelectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? address = null,
    Object? area = null,
    Object? additionalInfo = null,
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
      additionalInfo: null == additionalInfo
          ? _value.additionalInfo
          : additionalInfo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LocationSelectedImpl implements _LocationSelected {
  const _$LocationSelectedImpl(
      {required this.location,
      required this.address,
      required this.area,
      required this.additionalInfo});

  @override
  final LatLng location;
  @override
  final String address;
  @override
  final String area;
  @override
  final String additionalInfo;

  @override
  String toString() {
    return 'CheckoutState.locationSelected(location: $location, address: $address, area: $area, additionalInfo: $additionalInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationSelectedImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.additionalInfo, additionalInfo) ||
                other.additionalInfo == additionalInfo));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, location, address, area, additionalInfo);

  /// Create a copy of CheckoutState
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
    required TResult Function(
            LatLng location, String address, String area, String additionalInfo)
        locationSelected,
    required TResult Function() loading,
    required TResult Function(CheckoutResponse response) loaded,
    required TResult Function(String message) error,
    required TResult Function(String date, DateTime dateTime)
        deliveryTimeSelected,
  }) {
    return locationSelected(location, address, area, additionalInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult? Function()? loading,
    TResult? Function(CheckoutResponse response)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String date, DateTime dateTime)? deliveryTimeSelected,
  }) {
    return locationSelected?.call(location, address, area, additionalInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult Function()? loading,
    TResult Function(CheckoutResponse response)? loaded,
    TResult Function(String message)? error,
    TResult Function(String date, DateTime dateTime)? deliveryTimeSelected,
    required TResult orElse(),
  }) {
    if (locationSelected != null) {
      return locationSelected(location, address, area, additionalInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_RecipientSelected value) recipientSelected,
    required TResult Function(_LocationSelected value) locationSelected,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_DeliveryTimeSelected value) deliveryTimeSelected,
  }) {
    return locationSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
  }) {
    return locationSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
    required TResult orElse(),
  }) {
    if (locationSelected != null) {
      return locationSelected(this);
    }
    return orElse();
  }
}

abstract class _LocationSelected implements CheckoutState {
  const factory _LocationSelected(
      {required final LatLng location,
      required final String address,
      required final String area,
      required final String additionalInfo}) = _$LocationSelectedImpl;

  LatLng get location;
  String get address;
  String get area;
  String get additionalInfo;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationSelectedImplCopyWith<_$LocationSelectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$CheckoutStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'CheckoutState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String recipientName, String phoneNumber)
        recipientSelected,
    required TResult Function(
            LatLng location, String address, String area, String additionalInfo)
        locationSelected,
    required TResult Function() loading,
    required TResult Function(CheckoutResponse response) loaded,
    required TResult Function(String message) error,
    required TResult Function(String date, DateTime dateTime)
        deliveryTimeSelected,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult? Function()? loading,
    TResult? Function(CheckoutResponse response)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String date, DateTime dateTime)? deliveryTimeSelected,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult Function()? loading,
    TResult Function(CheckoutResponse response)? loaded,
    TResult Function(String message)? error,
    TResult Function(String date, DateTime dateTime)? deliveryTimeSelected,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_RecipientSelected value) recipientSelected,
    required TResult Function(_LocationSelected value) locationSelected,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_DeliveryTimeSelected value) deliveryTimeSelected,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements CheckoutState {
  const factory Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CheckoutResponse response});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$CheckoutStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? response = null,
  }) {
    return _then(_$LoadedImpl(
      null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as CheckoutResponse,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements Loaded {
  const _$LoadedImpl(this.response);

  @override
  final CheckoutResponse response;

  @override
  String toString() {
    return 'CheckoutState.loaded(response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode => Object.hash(runtimeType, response);

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String recipientName, String phoneNumber)
        recipientSelected,
    required TResult Function(
            LatLng location, String address, String area, String additionalInfo)
        locationSelected,
    required TResult Function() loading,
    required TResult Function(CheckoutResponse response) loaded,
    required TResult Function(String message) error,
    required TResult Function(String date, DateTime dateTime)
        deliveryTimeSelected,
  }) {
    return loaded(response);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult? Function()? loading,
    TResult? Function(CheckoutResponse response)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String date, DateTime dateTime)? deliveryTimeSelected,
  }) {
    return loaded?.call(response);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult Function()? loading,
    TResult Function(CheckoutResponse response)? loaded,
    TResult Function(String message)? error,
    TResult Function(String date, DateTime dateTime)? deliveryTimeSelected,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(response);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_RecipientSelected value) recipientSelected,
    required TResult Function(_LocationSelected value) locationSelected,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_DeliveryTimeSelected value) deliveryTimeSelected,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class Loaded implements CheckoutState {
  const factory Loaded(final CheckoutResponse response) = _$LoadedImpl;

  CheckoutResponse get response;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
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
    extends _$CheckoutStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckoutState
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
    return 'CheckoutState.error(message: $message)';
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

  /// Create a copy of CheckoutState
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
    required TResult Function(
            LatLng location, String address, String area, String additionalInfo)
        locationSelected,
    required TResult Function() loading,
    required TResult Function(CheckoutResponse response) loaded,
    required TResult Function(String message) error,
    required TResult Function(String date, DateTime dateTime)
        deliveryTimeSelected,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult? Function()? loading,
    TResult? Function(CheckoutResponse response)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String date, DateTime dateTime)? deliveryTimeSelected,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult Function()? loading,
    TResult Function(CheckoutResponse response)? loaded,
    TResult Function(String message)? error,
    TResult Function(String date, DateTime dateTime)? deliveryTimeSelected,
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
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_DeliveryTimeSelected value) deliveryTimeSelected,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements CheckoutState {
  const factory _Error({required final String message}) = _$ErrorImpl;

  String get message;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeliveryTimeSelectedImplCopyWith<$Res> {
  factory _$$DeliveryTimeSelectedImplCopyWith(_$DeliveryTimeSelectedImpl value,
          $Res Function(_$DeliveryTimeSelectedImpl) then) =
      __$$DeliveryTimeSelectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String date, DateTime dateTime});
}

/// @nodoc
class __$$DeliveryTimeSelectedImplCopyWithImpl<$Res>
    extends _$CheckoutStateCopyWithImpl<$Res, _$DeliveryTimeSelectedImpl>
    implements _$$DeliveryTimeSelectedImplCopyWith<$Res> {
  __$$DeliveryTimeSelectedImplCopyWithImpl(_$DeliveryTimeSelectedImpl _value,
      $Res Function(_$DeliveryTimeSelectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? dateTime = null,
  }) {
    return _then(_$DeliveryTimeSelectedImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$DeliveryTimeSelectedImpl implements _DeliveryTimeSelected {
  const _$DeliveryTimeSelectedImpl(
      {required this.date, required this.dateTime});

  @override
  final String date;
  @override
  final DateTime dateTime;

  @override
  String toString() {
    return 'CheckoutState.deliveryTimeSelected(date: $date, dateTime: $dateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeliveryTimeSelectedImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, dateTime);

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeliveryTimeSelectedImplCopyWith<_$DeliveryTimeSelectedImpl>
      get copyWith =>
          __$$DeliveryTimeSelectedImplCopyWithImpl<_$DeliveryTimeSelectedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String recipientName, String phoneNumber)
        recipientSelected,
    required TResult Function(
            LatLng location, String address, String area, String additionalInfo)
        locationSelected,
    required TResult Function() loading,
    required TResult Function(CheckoutResponse response) loaded,
    required TResult Function(String message) error,
    required TResult Function(String date, DateTime dateTime)
        deliveryTimeSelected,
  }) {
    return deliveryTimeSelected(date, dateTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult? Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult? Function()? loading,
    TResult? Function(CheckoutResponse response)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(String date, DateTime dateTime)? deliveryTimeSelected,
  }) {
    return deliveryTimeSelected?.call(date, dateTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String recipientName, String phoneNumber)?
        recipientSelected,
    TResult Function(LatLng location, String address, String area,
            String additionalInfo)?
        locationSelected,
    TResult Function()? loading,
    TResult Function(CheckoutResponse response)? loaded,
    TResult Function(String message)? error,
    TResult Function(String date, DateTime dateTime)? deliveryTimeSelected,
    required TResult orElse(),
  }) {
    if (deliveryTimeSelected != null) {
      return deliveryTimeSelected(date, dateTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_RecipientSelected value) recipientSelected,
    required TResult Function(_LocationSelected value) locationSelected,
    required TResult Function(Loading value) loading,
    required TResult Function(Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_DeliveryTimeSelected value) deliveryTimeSelected,
  }) {
    return deliveryTimeSelected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_RecipientSelected value)? recipientSelected,
    TResult? Function(_LocationSelected value)? locationSelected,
    TResult? Function(Loading value)? loading,
    TResult? Function(Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
  }) {
    return deliveryTimeSelected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_RecipientSelected value)? recipientSelected,
    TResult Function(_LocationSelected value)? locationSelected,
    TResult Function(Loading value)? loading,
    TResult Function(Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_DeliveryTimeSelected value)? deliveryTimeSelected,
    required TResult orElse(),
  }) {
    if (deliveryTimeSelected != null) {
      return deliveryTimeSelected(this);
    }
    return orElse();
  }
}

abstract class _DeliveryTimeSelected implements CheckoutState {
  const factory _DeliveryTimeSelected(
      {required final String date,
      required final DateTime dateTime}) = _$DeliveryTimeSelectedImpl;

  String get date;
  DateTime get dateTime;

  /// Create a copy of CheckoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeliveryTimeSelectedImplCopyWith<_$DeliveryTimeSelectedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
