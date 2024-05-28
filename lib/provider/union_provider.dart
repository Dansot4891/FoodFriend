import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/config/custom_dialog.dart';
import 'package:food_friend/config/firebase_instance.dart';
import 'package:food_friend/model/firebase_model.dart';
import 'package:food_friend/model/union_model.dart';
import 'package:food_friend/screens/home.dart';

final myUnionsProvider = Provider.family<List<UnionModel>, String>((ref, userid){
  List<UnionModel> data = ref.watch(unionProvider);

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

class UnionNotifier extends StateNotifier<List<UnionModel>> with FireBaseMixin{
  UnionNotifier():super([]);

  Future getData() async {
    try {
      final data = await getDocs('union');
      final unionList = data.map((e) => UnionModel.fromJson(e.data() as Map<String, dynamic>)).toList();
      state = unionList;
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

  Future EnterUnion({
    required UnionModel union,
    required BuildContext context,
    required String userid,
  }) async {
    String newNum = (int.parse(union.num) + 1).toString();

      for(var user in union.users){
        if(user == userid){
          CustomDialog(context: context, title: '이미 참가하신 팀입니다.', buttonText: '확인', buttonCount: 1, func: (){Navigator.pop(context);Navigator.pop(context);});
          return;
        }
      }
      
      union = union.copyWith(users: [...union.users, userid]);
    
    if(int.parse(newNum) > int.parse(union.max)){
      CustomDialog(context: context, title: '정원이 초과되었습니다.', buttonText: '확인', buttonCount: 1, func: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                return HomeScreen();
              }));
      });
      return;
    }

    final newData = UnionModel(id: union.id, max: union.max, num: newNum, place: union.place, time: union.time, title: union.title, type: union.type, userid: userid, dep: union.dep, users: union.users);

    await updateDoc('union', documentId: union.id, data: newData.toJson());
      // firestoreInstance
      //     .collection('union')
      //     .where('title', isEqualTo: union.title)
      //     .where('userid', isEqualTo: union.userid)
      //     .get()
      //     .then((QuerySnapshot querySnapshot) {
      //   querySnapshot.docs.forEach((doc) {
      //     firestoreInstance.collection('union').doc(doc.id).update({
      //       'title': union.title,
      //       'dep': union.dep,
      //       'max': union.max,
      //       'num': newNum,
      //       'place': union.place,
      //       'time': union.time,
      //       'type': union.type,
      //       'userid': union.userid,
      //       'users' : union.users,
      //     }).then((_) {
      //       CustomDialog(barrierDismissible: false, context: context, title: '참가가 완료되었습니다.', buttonText: '확인', buttonCount: 1, func: (){
      //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
      //           return HomeScreen();
      //         }));
      //       });
      //     }).catchError((error) {
      //       print('데이터 업데이트 실패: $error');
      //     });
      //   });
      // }).catchError((error) {
      //   print('변경 실패: $error');
      // });
  }

  Future changeUnion({
    required UnionModel union,
    required BuildContext context,
  }) async {
      firestoreInstance.collection('union').where('id', isEqualTo: union.id).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          firestoreInstance.collection('union').doc(doc.id).update({
            'id' : union.id,
            'title': union.title,
            'dep': union.dep,
            'max': union.max,
            'num': union.num,
            'place': union.place,
            'time': union.time,
            'type': union.type,
            'userid': union.userid,
            'users' : union.users,
          }).then((_) {
            CustomDialog(barrierDismissible: false, context: context, title: '수정이 완료되었습니다.', buttonText: '확인', buttonCount: 1, func: (){
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
      await deleteDoc('union', documentId: union.id);
      CustomDialog(context: context, title: '삭제가 완료되었습니다.', buttonText: '확인', buttonCount: 1, barrierDismissible: false, func: (){
          Navigator.push(context, MaterialPageRoute(builder: (_){
            return HomeScreen();
          }));
      });
      print('삭제 완료');
    } catch (e) {
      print(e);
    }
  }
}


