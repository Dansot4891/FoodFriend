import 'package:flutter_riverpod/flutter_riverpod.dart';

final genderProvider =
    StateNotifierProvider<GenderNotifier, String>((ref) => GenderNotifier());

class GenderNotifier extends StateNotifier<String> {
  GenderNotifier() : super("남자");

  void setGender(String gender){
    state = gender;
  }
}
