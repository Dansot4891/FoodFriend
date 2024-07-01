import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/model/firebase_model.dart';
import 'package:food_friend/model/union_model.dart';

final unionRepositoryProvider = Provider<UnionRepository>((ref) {
  return UnionRepository();
});

class UnionRepository with FireBaseMixin {
  
  Future<List<UnionModel>> getData() async {
      final data = await getDocs('union');
      final unionList = data.map((e) => UnionModel.fromJson(e.data() as Map<String, dynamic>)).toList();
      return unionList;
  }
}