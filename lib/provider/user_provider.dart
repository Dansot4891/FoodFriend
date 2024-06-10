import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/widget/custom_dialog.dart';
import 'package:food_friend/model/firebase_model.dart';
import 'package:food_friend/model/user_model.dart';
import 'package:food_friend/screens/home.dart';
import 'package:food_friend/screens/login.dart';

final UserProvider = StateNotifierProvider<UserNotifier, AppUser>((ref) => UserNotifier());

class UserNotifier extends StateNotifier<AppUser> with FireBaseMixin {
  UserNotifier()
      : super(AppUser(
            dep: 'dep',
            id: 'id',
            name: 'name',
            password: 'password',
            sex: 'sex'));

  // 아이디 중복 검사
  Future<bool> checkId(String userId) async {
    bool checked = false;
    final data = await getDocs('user');
      for(dynamic doc in data){
        final userData = AppUser.fromJson(doc.data());
        if(userData.id == userId){
          checked = true;
        }
      }
    return checked;
  }

  // 회원가입(아이디 중복 검사 포함)
  Future signUpFunc({
    required AppUser user,
    required BuildContext context,
  }) async {
    try {
      bool overlap = await checkId(user.id);
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
        await db.collection("user").doc().set(user.toJson()).then((_) {
          Navigator.push(context, MaterialPageRoute(builder: (_){
            return Login();
          }));
        });
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
      final snapshot = await getDocs('user');
      List<AppUser> users = snapshot.map((e) => AppUser.fromJson(e.data() as Map<String, dynamic>)).toList();
      bool loginState = false;
      // 아이디, 비밀번호 확인
      for (var userData in users) {
        if (userData.id == id && userData.password  == pw) {
          AppUser user = userData;
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
  }

  // 내 정보 변경(아이디 중보 검사, 비밀번호 확인 포함)
  Future ChangeUserData({
    required AppUser user,
    required BuildContext context,
    required WidgetRef ref,
    required String nowPw,
  }) async {
    final snapshot = await getDocs('user');
    List<AppUser> userData = snapshot.map((e) => AppUser.fromJson(e.data() as Map<String, dynamic>)).toList();
    for (var data in userData) {
      if (data.id == state.id && nowPw != data.password) {
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
      if (data.id == user.id && data.id != state.id) {
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
      db.collection('user').where('id', isEqualTo: state.id).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          db.collection('user').doc(doc.id).update(user.toJson()).then((_) {
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
