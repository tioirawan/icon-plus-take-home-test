// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_profile_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateProfileRequestDto {

 String? get name; String? get jobTitle; String? get company;
/// Create a copy of UpdateProfileRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateProfileRequestDtoCopyWith<UpdateProfileRequestDto> get copyWith => _$UpdateProfileRequestDtoCopyWithImpl<UpdateProfileRequestDto>(this as UpdateProfileRequestDto, _$identity);

  /// Serializes this UpdateProfileRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateProfileRequestDto&&(identical(other.name, name) || other.name == name)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.company, company) || other.company == company));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,jobTitle,company);

@override
String toString() {
  return 'UpdateProfileRequestDto(name: $name, jobTitle: $jobTitle, company: $company)';
}


}

/// @nodoc
abstract mixin class $UpdateProfileRequestDtoCopyWith<$Res>  {
  factory $UpdateProfileRequestDtoCopyWith(UpdateProfileRequestDto value, $Res Function(UpdateProfileRequestDto) _then) = _$UpdateProfileRequestDtoCopyWithImpl;
@useResult
$Res call({
 String? name, String? jobTitle, String? company
});




}
/// @nodoc
class _$UpdateProfileRequestDtoCopyWithImpl<$Res>
    implements $UpdateProfileRequestDtoCopyWith<$Res> {
  _$UpdateProfileRequestDtoCopyWithImpl(this._self, this._then);

  final UpdateProfileRequestDto _self;
  final $Res Function(UpdateProfileRequestDto) _then;

/// Create a copy of UpdateProfileRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? jobTitle = freezed,Object? company = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,jobTitle: freezed == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateProfileRequestDto].
extension UpdateProfileRequestDtoPatterns on UpdateProfileRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateProfileRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateProfileRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateProfileRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _UpdateProfileRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateProfileRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateProfileRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? jobTitle,  String? company)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateProfileRequestDto() when $default != null:
return $default(_that.name,_that.jobTitle,_that.company);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? jobTitle,  String? company)  $default,) {final _that = this;
switch (_that) {
case _UpdateProfileRequestDto():
return $default(_that.name,_that.jobTitle,_that.company);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? jobTitle,  String? company)?  $default,) {final _that = this;
switch (_that) {
case _UpdateProfileRequestDto() when $default != null:
return $default(_that.name,_that.jobTitle,_that.company);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateProfileRequestDto implements UpdateProfileRequestDto {
  const _UpdateProfileRequestDto({this.name, this.jobTitle, this.company});
  factory _UpdateProfileRequestDto.fromJson(Map<String, dynamic> json) => _$UpdateProfileRequestDtoFromJson(json);

@override final  String? name;
@override final  String? jobTitle;
@override final  String? company;

/// Create a copy of UpdateProfileRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateProfileRequestDtoCopyWith<_UpdateProfileRequestDto> get copyWith => __$UpdateProfileRequestDtoCopyWithImpl<_UpdateProfileRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateProfileRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateProfileRequestDto&&(identical(other.name, name) || other.name == name)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.company, company) || other.company == company));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,jobTitle,company);

@override
String toString() {
  return 'UpdateProfileRequestDto(name: $name, jobTitle: $jobTitle, company: $company)';
}


}

/// @nodoc
abstract mixin class _$UpdateProfileRequestDtoCopyWith<$Res> implements $UpdateProfileRequestDtoCopyWith<$Res> {
  factory _$UpdateProfileRequestDtoCopyWith(_UpdateProfileRequestDto value, $Res Function(_UpdateProfileRequestDto) _then) = __$UpdateProfileRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? jobTitle, String? company
});




}
/// @nodoc
class __$UpdateProfileRequestDtoCopyWithImpl<$Res>
    implements _$UpdateProfileRequestDtoCopyWith<$Res> {
  __$UpdateProfileRequestDtoCopyWithImpl(this._self, this._then);

  final _UpdateProfileRequestDto _self;
  final $Res Function(_UpdateProfileRequestDto) _then;

/// Create a copy of UpdateProfileRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? jobTitle = freezed,Object? company = freezed,}) {
  return _then(_UpdateProfileRequestDto(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,jobTitle: freezed == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
