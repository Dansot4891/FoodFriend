import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/config/custom_dialog.dart';
import 'package:food_friend/config/firebase_instance.dart';
import 'package:food_friend/model/firebase_model.dart';
import 'package:food_friend/model/user_model.dart';
import 'package:food_friend/screens/home.dart';
import 'package:food_friend/screens/login.dart';

final UserProvider =
    StateNotifierProvider<UserNotifier, AppUser>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<AppUser> with FireBaseMixin {
  UserNotifier()
      : super(AppUser(
            dep: 'dep',
            id: 'id',
            name: 'name',
            password: 'password',
            sex: 'sex'));

  Future<List<AppUser>> testFunc() async {
    final snapshot = await getDocs('user');

    // 비밀번호 Null 처리
    List<AppUser> users = snapshot.map((e) {
      Map<String, dynamic> data = e.data() as Map<String, dynamic>;
      
      data.remove('password');

      return AppUser.fromJson(data);
    }).toList();
    
    print(users);
    return users;
  }

  // 회원가입(아이디 중복 검사 포함)
  Future signUpFunc({
    required AppUser user,
    required BuildContext context,
  }) async {
    try {
      CollectionReference<Map<String, dynamic>> collectionReference = FirebaseFirestore.instance.collection("user");
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await collectionReference.orderBy("id").get();
      bool overlap = false;
      for (var doc in querySnapshot.docs) {
        if (doc.data()['id'] == user.id) {
          overlap = true;
        }
      }
      if (overlap) {
        CustomDialog(
            context: context,
            title: '중복된 아이디가 존재합니다.\n다른 아이디를 사용해주세요.',
            buttonText: '확인',
            buttonCount: 1,
            func: () {
              Navigator.pop(context);
            });
      } else {
        await firestoreInstance.collection('user').doc().set(user.toJson());
        Navigator.push(context, MaterialPageRoute(builder: (_){
          return Login();
        }));
        print('회원가입 성공');
      }
    } catch (e) {
      print(e);
    }
  }

  // 로그인(Dialog 포함)
  Future LoginFunc({
    required String id,
    required String pw,
    required BuildContext context,
  }) async {
    try {
      CollectionReference<Map<String, dynamic>> collectionReference =
          FirebaseFirestore.instance.collection("user");
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collectionReference.orderBy("id").get();
      bool loginState = false;
      for (var doc in querySnapshot.docs) {
        if (doc.data()['id'] == id && doc.data()['password'] == pw) {
          AppUser user = AppUser.fromJson(doc.data());
          user = user.copyWith(password: null);
          state = user;
          loginState = true;
        }
      }
      if (loginState) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
      if (!loginState) {
        CustomDialog(
            context: context,
            title: '로그인 오류\n로그인 정보를 확인해주세요.',
            buttonText: '확인',
            buttonCount: 1,
            func: () {
              Navigator.pop(context);
            });
      }
    } catch (e) {
      print(e);
    }
  }

  // 로그아웃(유저데이터 초기화)
  void LogoutFunc() {
    state = AppUser(
        dep: 'dep', id: 'id', name: 'name', password: 'password', sex: 'sex');
  }

  // 성별 변경 함수
  void ChangeGender() {
    if (state.sex == '남자') {
      state = state.copyWith(sex: '여자');
    } else {
      state = state.copyWith(sex: '남자');
    }
    print(state);
  }

  // 내 정보 변경(아이디 중보 검사, 비밀번호 확인 포함)
  Future ChangeUserData({
    required AppUser user,
    required BuildContext context,
    required WidgetRef ref,
    required String nowPw,
  }) async {
    CollectionReference<Map<String, dynamic>> collectionReference = FirebaseFirestore.instance.collection("user");
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await collectionReference.orderBy("id").get();
    
    for (var doc in querySnapshot.docs) {
      if (doc.data()['id'] == state.id) {
        if(nowPw != doc.data()['password']){
          CustomDialog(
            context: context,
            title: '비밀번호를 확인해주세요.',
            buttonText: '확인',
            buttonCount: 1,
            func: () {
              Navigator.pop(context);
          });  
          return;
        }
      }

      if (doc.data()['id'] == user.id && doc.data()['id'] != state.id) {
        CustomDialog(
          context: context,
          title: '중복된 아이디가 존재합니다.\n다른 아이디를 사용해주세요.',
          buttonText: '확인',
          buttonCount: 1,
          func: () {
            Navigator.pop(context);
          });
          return;
      }
    }

      firestoreInstance
          .collection('user')
          .where('id', isEqualTo: state.id)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          firestoreInstance.collection('user').doc(doc.id).update({
            'id': user.id,
            'password': user.password,
            'name': user.name,
            'dep': user.dep,
            'sex': user.sex,
          }).then((_) {
            CustomDialog(
                context: context,
                title: '변경이 완료되었습니다.\n재로그인 해주세요.',
                buttonText: '확인',
                buttonCount: 1,
                barrierDismissible: false,
                func: () {
                  ref.read(UserProvider.notifier).LogoutFunc();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) {
                    return Login();
                  }));
                });
            print('데이터 업데이트 완료');
          }).catchError((error) {
            print('데이터 업데이트 실패: $error');
          });
        });
      }).catchError((error) {
        print('변경 실패: $error');
      });
  }
}
