import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/config/custom_dialog.dart';
import 'package:food_friend/config/firebase_instance.dart';
import 'package:food_friend/model/union_model.dart';
import 'package:food_friend/screens/home.dart';

//final myUnionProvider = Provider.family<List

final myUnionsProvider = Provider.family<List<UnionModel>, String>((ref, userid){
  List<UnionModel> data = ref.watch(unionProvider);

  print(data);
  List<UnionModel> selectedData = [];
  for(var dt in data){
    if(dt.userid == userid){
      selectedData.add(dt);
    }
  }
  return selectedData;
});

final unionSelectedProvider = Provider.family<List<UnionModel>, String>((ref, category) {
  List<UnionModel> data = ref.watch(unionProvider);

  if(category == '전체'){
      return data;
    }
    List<UnionModel> selectedData = [];
    for(var dt in data){
      if(dt.type == category){
        selectedData.add(dt);
      }
    }
    return selectedData;
});

final unionProvider = StateNotifierProvider<UnionNotifier, List<UnionModel>>((ref) => UnionNotifier());

class UnionNotifier extends StateNotifier<List<UnionModel>>{
  UnionNotifier():super([]);

  Future getData() async {
    try {
      CollectionReference<Map<String, dynamic>> collectionReference = FirebaseFirestore.instance.collection("union");
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await collectionReference.orderBy("title").get();
      List<UnionModel> data = [];
      for (var doc in querySnapshot.docs) {
        data.add(UnionModel.fromJson(doc.data()));
      }
      state = data;
    } catch (e) {
      print(e);
    }
  }

  List<UnionModel> setCategory(String category){
    if(category == '전체'){
      return state;
    }
    List<UnionModel> data = [];
    for(var dt in state){
      if(dt.type == category){
        data.add(dt);
      }
    }
    return data;
  }

  Future changeUnion({
    required UnionModel union,
    required BuildContext context,
    String? title
  }) async {
    String newNum = (int.parse(union.num) + 1).toString();
    if(int.parse(newNum) > int.parse(union.max) && title == null){
      CustomDialog(context: context, title: '정원이 초과되었습니다.', buttonText: '확인', buttonCount: 1, func: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                return HomeScreen();
              }));
      });
      return;
    }
      firestoreInstance
          .collection('union')
          .where('title', isEqualTo: title == null ? union.title : title)
          .where('userid', isEqualTo: union.userid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          firestoreInstance.collection('union').doc(doc.id).update({
            'title': union.title,
            'dep': union.dep,
            'max': union.max,
            'num': title == null ? newNum : union.num,
            'place': union.place,
            'time': union.time,
            'type': union.type,
            'userid': union.userid,
          }).then((_) {
            CustomDialog(barrierDismissible: false, context: context, title: title == null ? '참가가 완료되었습니다.' : '수정이 완료되었습니다.', buttonText: '확인', buttonCount: 1, func: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                return HomeScreen();
              }));
            });
          }).catchError((error) {
            print('데이터 업데이트 실패: $error');
          });
        });
      }).catchError((error) {
        print('변경 실패: $error');
      });
  }

  Future deleteData(UnionModel union, BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await firestoreInstance
          .collection('union')
          .where('title', isEqualTo: union.title)
          .where('userid', isEqualTo: union.userid)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
        CustomDialog(context: context, title: '삭제가 완료되었습니다.', buttonText: '확인', buttonCount: 1, barrierDismissible: false, func: (){
          Navigator.push(context, MaterialPageRoute(builder: (_){
            return HomeScreen();
          }));
        });
      }
      print('삭제 완료');
    } catch (e) {
      print(e);
    }
  }
}


