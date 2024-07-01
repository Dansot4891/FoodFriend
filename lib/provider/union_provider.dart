import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/repository/union_repository.dart';
import 'package:food_friend/widget/custom_dialog.dart';
import 'package:food_friend/model/firebase_model.dart';
import 'package:food_friend/model/union_model.dart';
import 'package:food_friend/screens/home.dart';

// 개인 유저의 union Provider
final myUnionsProvider =
    Provider.family<List<UnionModel>, String>((ref, userid) {
  List<UnionModel> data = ref.watch(unionProvider);

  List<UnionModel> selectedData =
      data.where((e) => e.userid == userid).toList();

  return selectedData;
});

// 선택된 union Provider
final unionSelectedProvider =
    Provider.family<List<UnionModel>, String>((ref, category) {
  List<UnionModel> data = ref.watch(unionProvider);

  if (category == '전체') {
    return data;
  }

  List<UnionModel> selectedData = [];
  selectedData = data.where((e) => e.type == category).toList();
  return selectedData;
});

// 전체 union Provider
final unionProvider = StateNotifierProvider<UnionNotifier, List<UnionModel>>(
  (ref) {
    final repo = ref.watch(unionRepositoryProvider);
    return UnionNotifier(repository: repo);
  },
);

// 전체 union Notifier
class UnionNotifier extends StateNotifier<List<UnionModel>> with FireBaseMixin {
  final UnionRepository repository;
  UnionNotifier({
    required this.repository,
  }) : super([]) {
    getData();
  }

  Future getData() async {
    final resp = await repository.getData();
    state = resp;
  }

  Future EnterUnion({
    required UnionModel union,
    required BuildContext context,
    required String userid,
  }) async {
    // 참가자 수 증가
    String newNum = (int.parse(union.num) + 1).toString();

    // 참가자 리스트에 유저 id 추가
    union = union.copyWith(users: [...union.users, userid]);

    if (int.parse(newNum) > int.parse(union.max)) {
      CustomDialog(
        context: context,
        title: '정원이 초과되었습니다.',
        buttonText: '확인',
        buttonCount: 1,
        func: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) {
                return HomeScreen();
              },
            ),
          );
        },
      );
      return;
    }

    // 최종 데이터
    final newData = UnionModel(
        id: union.id,
        max: union.max,
        num: newNum,
        place: union.place,
        time: union.time,
        title: union.title,
        type: union.type,
        userid: union.userid,
        dep: union.dep,
        users: union.users);

    await updateDoc('union', documentId: union.id!, data: newData.toJson())
        .then(
      (_) {
        CustomDialog(
          barrierDismissible: false,
          context: context,
          title: '참가가 완료되었습니다.',
          buttonText: '확인',
          buttonCount: 1,
          func: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return HomeScreen();
                },
              ),
            );
          },
        );
      },
    );
  }

  Future changeUnion({
    required UnionModel union,
    required BuildContext context,
  }) async {
    await updateDoc('union', documentId: union.id!, data: union.toJson()).then(
      (_) {
        CustomDialog(
          barrierDismissible: false,
          context: context,
          title: '수정이 완료되었습니다.',
          buttonText: '확인',
          buttonCount: 1,
          func: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return HomeScreen();
                },
              ),
            );
          },
        );
      },
    );
  }

  Future deleteData(UnionModel union, BuildContext context) async {
    try {
      await deleteDoc('union', documentId: union.id!);
      CustomDialog(
        context: context,
        title: '삭제가 완료되었습니다.',
        buttonText: '확인',
        buttonCount: 1,
        barrierDismissible: false,
        func: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return HomeScreen();
              },
            ),
          );
        },
      );
      print('삭제 완료');
    } catch (e) {
      print(e);
    }
  }

  Future makeGroup({required UnionModel union}) async {
    final docUnion = db.collection('union').doc();
    final newData = union.copyWith(id: docUnion.id);
    await docUnion.set(newData.toJson());
  }
}
