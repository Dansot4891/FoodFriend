// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecommendationImpl _$$RecommendationImplFromJson(Map<String, dynamic> json) =>
    _$RecommendationImpl(
      type: json['type'] as String,
      name: json['name'] as String,
      imgPath: json['imgPath'] as String,
    );

Map<String, dynamic> _$$RecommendationImplToJson(
        _$RecommendationImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'imgPath': instance.imgPath,
    };
