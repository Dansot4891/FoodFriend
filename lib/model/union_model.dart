import 'package:freezed_annotation/freezed_annotation.dart';

part 'union_model.freezed.dart';
part 'union_model.g.dart';

@freezed
class UnionModel with _$UnionModel {

  factory UnionModel({
    required String max,
    required String num,
    required String place,
    required String time,
    required String title,
    required String type,
    required String userid,
    required String dep,
  }) = _UnionModel;

  factory UnionModel.fromJson(Map<String, dynamic> json) => _$UnionModelFromJson(json);
}