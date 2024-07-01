import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/model/firebase_model.dart';
import 'package:food_friend/model/recommend_model.dart';

final recommendRepositoryProvider = Provider<RecommendRepository>((ref){
  return RecommendRepository();
});

class RecommendRepository with FireBaseMixin{
  
  Future<List<Recommendation>> getData() async {
    final data = await getDocs('recommend');
    final dataList = data.map((e) => Recommendation.fromJson(e.data() as Map<String, dynamic>)).toList();
    return dataList;
  }
}