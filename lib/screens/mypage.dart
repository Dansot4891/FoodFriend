import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/config/firebase_instance.dart';
import 'package:food_friend/config/validator.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/model/user_model.dart';
import 'package:food_friend/provider/user_provider.dart';
import 'package:food_friend/widget/custom_textfield.dart';

enum Sex { male, femail }

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppUser user = ref.watch(UserProvider);
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    TextEditingController _nameController = TextEditingController(text: user.name);
    TextEditingController _idController = TextEditingController(text: user.id);
    TextEditingController _pwController = TextEditingController();
    TextEditingController _pw2Controller = TextEditingController();
    TextEditingController _depController = TextEditingController(text: user.dep);
    Sex? _sex = user.sex == "남자" ? Sex.male : Sex.femail;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '마이페이지',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(
              Icons.forward,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: Container(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '이름',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: ratio.height * 5,),
                        CustomTextField(controller: _nameController, hintText: '이름을 입력해주세요.', validator: nameValidator,),
                        SizedBox(height: ratio.height * 25,),
                        Text(
                          '아이디',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: ratio.height * 5,),
                        CustomTextField(controller: _idController, hintText: '아이디를 입력해주세요.', validator: idValidator,),
                        // _userEmail(),
                        SizedBox(height: ratio.height * 25,),
                        Text(
                          '비밀번호',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: ratio.height * 5,),
                        CustomTextField(controller: _pwController, hintText: '현재 비밀번호를 입력해주세요.', validator: pwValidator, obscure: true,),
                        SizedBox(height: ratio.height * 5,),
                        CustomTextField(controller: _pw2Controller, hintText: '새 비밀번호를 입력해주세요.', validator: pwValidator, obscure: true,),
                        SizedBox(
                          height: ratio.height * 25,
                        ),
                        Text(
                          '학과',
                          style: TextStyle(fontSize: 15),
                        ),
                        CustomTextField(controller: _depController, hintText: '학과를 입력해주세요.', validator: depValidator,),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text('성별을 체크해주세요.'),
                      RadioListTile(
                        title: Text('남자'),
                        value: Sex.male,
                        groupValue: _sex,
                        onChanged: (value) {
                          ref.read(UserProvider.notifier).ChangeGender();
                        },
                      ),
                      RadioListTile(
                        title: Text('여자'),
                        value: Sex.femail,
                        groupValue: _sex,
                        onChanged: (value) {
                          ref.read(UserProvider.notifier).ChangeGender();
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: (){
                      if (_formkey.currentState!.validate()) {
                        AppUser userData = AppUser(dep: _depController.text, id: _idController.text, name: _nameController.text, sex: _sex == Sex.male ? '남자' : '여자', password: _pwController.text);
                      } else {}
                    },
                    child: Text(
                      '내 정보 변경하기',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // void updateUser(AppUser userData, GlobalKey formkey) async {    
  //   bool overlap = false;
  //   if (formkey.currentState!.validate()) {
  //     for (var user in users) {
  //       if (userid == user.id && id != userid) {
  //         showDialog(
  //           context: context,
  //           barrierDismissible: true,
  //           builder: ((context) {
  //             return AlertDialog(
  //               title: Text("아이디 중복"),
  //               content: Text("중복되는 아이디가 존재합니다.\n다른 아이디를 입력해주세요."),
  //               actions: <Widget>[
  //                 Container(
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: Text("확인"),
  //                   ),
  //                 ),
  //               ],
  //             );
  //           }),
  //         );
  //         overlap = true;
  //       } 
  //     }if(overlap == false) {
          
  //       }
  //   } else {}
  // }
}

