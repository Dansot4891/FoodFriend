// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'union_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnionModelImpl _$$UnionModelImplFromJson(Map<String, dynamic> json) =>
    _$UnionModelImpl(
      max: json['max'] as String,
      num: json['num'] as String,
      place: json['place'] as String,
      time: json['time'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      userid: json['userid'] as String,
      dep: json['dep'] as String,
    );

Map<String, dynamic> _$$UnionModelImplToJson(_$UnionModelImpl instance) =>
    <String, dynamic>{
      'max': instance.max,
      'num': instance.num,
      'place': instance.place,
      'time': instance.time,
      'title': instance.title,
      'type': instance.type,
      'userid': instance.userid,
      'dep': instance.dep,
    };
