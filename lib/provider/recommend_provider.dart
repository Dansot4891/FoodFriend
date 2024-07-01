import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/model/firebase_model.dart';
import 'package:food_friend/model/recommend_model.dart';
import 'package:food_friend/repository/recommend_repository.dart';

// 랜덤 선택 추천
final selectedRecommendProvider = Provider.family<List<Recommendation>, String>((ref, type){
  final recommendData = ref.watch(recommendProvider);
  List<Recommendation> selectedData = recommendData.where((e) => e.type == type).toList();
  return selectedData;
});

// 전체 추천
final recommendProvider = StateNotifierProvider<RecommendNotifier, List<Recommendation>>((ref) {
  final RecommendRepository repo = ref.watch(recommendRepositoryProvider);

  return RecommendNotifier(repository: repo);
});

class RecommendNotifier extends StateNotifier<List<Recommendation>> with FireBaseMixin{
  final RecommendRepository repository;
  RecommendNotifier({
    required this.repository
  }):super([]){
    getData();
  }

  Future<void> getData() async {
    final resp = await repository.getData();
    state = resp;
  }

  Future<void> makeData() async {
    Recommendation data = Recommendation(type: '한식', name: '삼겹살', imgPath: 'https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyNDAyMjJfNzQg%2FMDAxNzA4NTU2ODIzNzc3.IDDSVSny7CTsat5zggjUS1OKBImJ4Jp3WdRvfCIloSog.vRX7_rAt_5qf7NoORlrD7OppX1Ik7Ktjm5jnvRfB-PQg.JPEG%2FIMG_3523.jpg&type=sc960_832');
    await db.collection('recommend').doc().set(data.toJson());
    print('성공');
  }
}