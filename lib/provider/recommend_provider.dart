import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/model/firebase_model.dart';
import 'package:food_friend/model/recommend_model.dart';

final selectedRecommendProvider = Provider.family<List<Recommendation>, String>((ref, type){
  final recommendData = ref.watch(recommendProvider);
  List<Recommendation> selectedData = recommendData.where((e) => e.type == type).toList();
  return selectedData;
});

final recommendProvider = StateNotifierProvider<RecommendNotifier, List<Recommendation>>((ref) => RecommendNotifier());

class RecommendNotifier extends StateNotifier<List<Recommendation>> with FireBaseMixin{
  RecommendNotifier():super([]);

  Future<void> fetchData() async {
    final snapshot = await getDocs('recommend');
    state = snapshot.map((e) => Recommendation.fromJson(e.data() as Map<String, dynamic>)).toList();
  }


  Recommendation randomData(String type){
    Random random = Random();
    List<Recommendation> selectedData = state.where((e) => e.type == type).toList();
    int index = random.nextInt(selectedData.length);
    return selectedData[index];
  }

  Future<void> makeData() async {
    Recommendation data = Recommendation(type: '한식', name: '삼겹살', imgPath: 'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDAyMjJfNzQg%2FMDAxNzA4NTU2ODIzNzc3.IDDSVSny7CTsat5zggjUS1OKBImJ4Jp3WdRvfCIloSog.vRX7_rAt_5qf7NoORlrD7OppX1Ik7Ktjm5jnvRfB-PQg.JPEG%2FIMG_3523.jpg&type=sc960_832');
    await db.collection('recommend').doc().set(data.toJson());
    print('성공');
  }
}