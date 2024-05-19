// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      dep: json['dep'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      password: json['password'] as String?,
      sex: json['sex'] as String,
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'dep': instance.dep,
      'id': instance.id,
      'name': instance.name,
      'password': instance.password,
      'sex': instance.sex,
    };
