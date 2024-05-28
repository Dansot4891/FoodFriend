import 'package:freezed_annotation/freezed_annotation.dart';

part 'recommend_model.freezed.dart';
part 'recommend_model.g.dart';

@freezed
class Recommendation with _$Recommendation {

  factory Recommendation({
    required String type,
    required String name,
    required String imgPath,
  }) = _Recommendation;

  factory Recommendation.fromJson(Map<String, dynamic> json) => _$RecommendationFromJson(json);
}