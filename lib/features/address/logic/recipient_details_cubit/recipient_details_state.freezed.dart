// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipient_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecipientDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            String? recipientName,
            String? phoneNumber,
            String? area,
            String? address,
            String? extraDetails,
            LatLng? location)
        initialized,
    required TResult Function(LatLng location, String address, String area)
        locationUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? recipientName, String? phoneNumber, String? area,
            String? address, String? extraDetails, LatLng? location)?
        initialized,
    TResult? Function(LatLng location, String address, String area)?
        locationUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? recipientName, String? phoneNumber, String? area,
            String? address, String? extraDetails, LatLng? location)?
        initialized,
    TResult Function(LatLng location, String address, String area)?
        locationUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_LocationUpdated value) locationUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Initialized value)? initialized,
    TResult? Function(_LocationUpdated value)? locationUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Initialized value)? initialized,
    TResult Function(_LocationUpdated value)? locationUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipientDetailsStateCopyWith<$Res> {
  factory $RecipientDetailsStateCopyWith(RecipientDetailsState value,
          $Res Function(RecipientDetailsState) then) =
      _$RecipientDetailsStateCopyWithImpl<$Res, RecipientDetailsState>;
}

/// @nodoc
class _$RecipientDetailsStateCopyWithImpl<$Res,
        $Val extends RecipientDetailsState>
    implements $RecipientDetailsStateCopyWith<$Res> {
  _$RecipientDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipientDetailsState
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
    extends _$RecipientDetailsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipientDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'RecipientDetailsState.initial()';
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
    required TResult Function(
            String? recipientName,
            String? phoneNumber,
            String? area,
            String? address,
            String? extraDetails,
            LatLng? location)
        initialized,
    required TResult Function(LatLng location, String address, String area)
        locationUpdated,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? recipientName, String? phoneNumber, String? area,
            String? address, String? extraDetails, LatLng? location)?
        initialized,
    TResult? Function(LatLng location, String address, String area)?
        locationUpdated,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? recipientName, String? phoneNumber, String? area,
            String? address, String? extraDetails, LatLng? location)?
        initialized,
    TResult Function(LatLng location, String address, String area)?
        locationUpdated,
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
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_LocationUpdated value) locationUpdated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Initialized value)? initialized,
    TResult? Function(_LocationUpdated value)? locationUpdated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Initialized value)? initialized,
    TResult Function(_LocationUpdated value)? locationUpdated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements RecipientDetailsState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$InitializedImplCopyWith<$Res> {
  factory _$$InitializedImplCopyWith(
          _$InitializedImpl value, $Res Function(_$InitializedImpl) then) =
      __$$InitializedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String? recipientName,
      String? phoneNumber,
      String? area,
      String? address,
      String? extraDetails,
      LatLng? location});
}

/// @nodoc
class __$$InitializedImplCopyWithImpl<$Res>
    extends _$RecipientDetailsStateCopyWithImpl<$Res, _$InitializedImpl>
    implements _$$InitializedImplCopyWith<$Res> {
  __$$InitializedImplCopyWithImpl(
      _$InitializedImpl _value, $Res Function(_$InitializedImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipientName = freezed,
    Object? phoneNumber = freezed,
    Object? area = freezed,
    Object? address = freezed,
    Object? extraDetails = freezed,
    Object? location = freezed,
  }) {
    return _then(_$InitializedImpl(
      recipientName: freezed == recipientName
          ? _value.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      area: freezed == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      extraDetails: freezed == extraDetails
          ? _value.extraDetails
          : extraDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng?,
    ));
  }
}

/// @nodoc

class _$InitializedImpl implements _Initialized {
  const _$InitializedImpl(
      {this.recipientName,
      this.phoneNumber,
      this.area,
      this.address,
      this.extraDetails,
      this.location});

  @override
  final String? recipientName;
  @override
  final String? phoneNumber;
  @override
  final String? area;
  @override
  final String? address;
  @override
  final String? extraDetails;
  @override
  final LatLng? location;

  @override
  String toString() {
    return 'RecipientDetailsState.initialized(recipientName: $recipientName, phoneNumber: $phoneNumber, area: $area, address: $address, extraDetails: $extraDetails, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitializedImpl &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.extraDetails, extraDetails) ||
                other.extraDetails == extraDetails) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recipientName, phoneNumber, area,
      address, extraDetails, location);

  /// Create a copy of RecipientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitializedImplCopyWith<_$InitializedImpl> get copyWith =>
      __$$InitializedImplCopyWithImpl<_$InitializedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            String? recipientName,
            String? phoneNumber,
            String? area,
            String? address,
            String? extraDetails,
            LatLng? location)
        initialized,
    required TResult Function(LatLng location, String address, String area)
        locationUpdated,
  }) {
    return initialized(
        recipientName, phoneNumber, area, address, extraDetails, location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? recipientName, String? phoneNumber, String? area,
            String? address, String? extraDetails, LatLng? location)?
        initialized,
    TResult? Function(LatLng location, String address, String area)?
        locationUpdated,
  }) {
    return initialized?.call(
        recipientName, phoneNumber, area, address, extraDetails, location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? recipientName, String? phoneNumber, String? area,
            String? address, String? extraDetails, LatLng? location)?
        initialized,
    TResult Function(LatLng location, String address, String area)?
        locationUpdated,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(
          recipientName, phoneNumber, area, address, extraDetails, location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_LocationUpdated value) locationUpdated,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Initialized value)? initialized,
    TResult? Function(_LocationUpdated value)? locationUpdated,
  }) {
    return initialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Initialized value)? initialized,
    TResult Function(_LocationUpdated value)? locationUpdated,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class _Initialized implements RecipientDetailsState {
  const factory _Initialized(
      {final String? recipientName,
      final String? phoneNumber,
      final String? area,
      final String? address,
      final String? extraDetails,
      final LatLng? location}) = _$InitializedImpl;

  String? get recipientName;
  String? get phoneNumber;
  String? get area;
  String? get address;
  String? get extraDetails;
  LatLng? get location;

  /// Create a copy of RecipientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitializedImplCopyWith<_$InitializedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LocationUpdatedImplCopyWith<$Res> {
  factory _$$LocationUpdatedImplCopyWith(_$LocationUpdatedImpl value,
          $Res Function(_$LocationUpdatedImpl) then) =
      __$$LocationUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LatLng location, String address, String area});
}

/// @nodoc
class __$$LocationUpdatedImplCopyWithImpl<$Res>
    extends _$RecipientDetailsStateCopyWithImpl<$Res, _$LocationUpdatedImpl>
    implements _$$LocationUpdatedImplCopyWith<$Res> {
  __$$LocationUpdatedImplCopyWithImpl(
      _$LocationUpdatedImpl _value, $Res Function(_$LocationUpdatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? address = null,
    Object? area = null,
  }) {
    return _then(_$LocationUpdatedImpl(
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

class _$LocationUpdatedImpl implements _LocationUpdated {
  const _$LocationUpdatedImpl(
      {required this.location, required this.address, required this.area});

  @override
  final LatLng location;
  @override
  final String address;
  @override
  final String area;

  @override
  String toString() {
    return 'RecipientDetailsState.locationUpdated(location: $location, address: $address, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationUpdatedImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.area, area) || other.area == area));
  }

  @override
  int get hashCode => Object.hash(runtimeType, location, address, area);

  /// Create a copy of RecipientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationUpdatedImplCopyWith<_$LocationUpdatedImpl> get copyWith =>
      __$$LocationUpdatedImplCopyWithImpl<_$LocationUpdatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            String? recipientName,
            String? phoneNumber,
            String? area,
            String? address,
            String? extraDetails,
            LatLng? location)
        initialized,
    required TResult Function(LatLng location, String address, String area)
        locationUpdated,
  }) {
    return locationUpdated(location, address, area);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String? recipientName, String? phoneNumber, String? area,
            String? address, String? extraDetails, LatLng? location)?
        initialized,
    TResult? Function(LatLng location, String address, String area)?
        locationUpdated,
  }) {
    return locationUpdated?.call(location, address, area);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String? recipientName, String? phoneNumber, String? area,
            String? address, String? extraDetails, LatLng? location)?
        initialized,
    TResult Function(LatLng location, String address, String area)?
        locationUpdated,
    required TResult orElse(),
  }) {
    if (locationUpdated != null) {
      return locationUpdated(location, address, area);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_LocationUpdated value) locationUpdated,
  }) {
    return locationUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Initialized value)? initialized,
    TResult? Function(_LocationUpdated value)? locationUpdated,
  }) {
    return locationUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Initialized value)? initialized,
    TResult Function(_LocationUpdated value)? locationUpdated,
    required TResult orElse(),
  }) {
    if (locationUpdated != null) {
      return locationUpdated(this);
    }
    return orElse();
  }
}

abstract class _LocationUpdated implements RecipientDetailsState {
  const factory _LocationUpdated(
      {required final LatLng location,
      required final String address,
      required final String area}) = _$LocationUpdatedImpl;

  LatLng get location;
  String get address;
  String get area;

  /// Create a copy of RecipientDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationUpdatedImplCopyWith<_$LocationUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
