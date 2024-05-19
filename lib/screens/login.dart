import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/config/validator.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/provider/user_provider.dart';
import 'package:food_friend/screens/signup.dart';
import 'dart:io';


class Login extends ConsumerWidget {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'FF Login',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.exit_to_app), onPressed: () => exit(0)),
        ),
        body: Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(30)),
                      Image(image: AssetImage('assets/lunch.png')),
                      Container(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          children: [
                            _userId(),
                            SizedBox(
                              height: ratio.height*15,
                            ),
                            _userPw(),
                            SizedBox(
                              height: ratio.height*30,
                            ),
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.all(20)),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignupScreen()));
                                    },
                                    child: Text('회원가입하기',
                                        style: TextStyle(color: Colors.white)),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                    )),
                                SizedBox(
                                  width: ratio.width*30,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    ref.read(UserProvider.notifier).LoginFunc(id: _idController.text, pw: _pwController.text, context: context);
                                  },
                                  child: Text('  로그인  ',
                                      style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _userId() {
    return TextFormField(
      controller: _idController,
      decoration: const InputDecoration(
        hintText: '아이디를 입력해주세요.',
      ),
      validator: idValidator,
    );
  }

  Widget _userPw() {
    return TextFormField(
      controller: _pwController,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(hintText: '비밀번호를 입력해주세요.'),
      validator: pwValidator,
    );
  }

  // void getData() async {
  //   List<FFUser> users = await getFireModels();
  //   bool loginState = false;
  //   if (_formkey.currentState!.validate()) {
  //     for (var user in users) {
  //       if (_idController.text == user.id && _pwController.text == user.password) {
  //         loginState = true;
  //         Get.to(() => Home(), arguments: [user.name, user.dep, user.id]);
  //         break;
  //       }
  //     }
  //     if(loginState == false){
  //       showDialog(
  //             context: context,
  //             barrierDismissible: true,
  //             builder: ((context) {
  //               return AlertDialog(
  //                 title: Text("로그인 오류"),
  //                 content: Text("로그인 정보를 확인해주세요."),
  //                 actions: <Widget>[
  //                   Container(
  //                     child: ElevatedButton(
  //                       onPressed: () {
  //                         Navigator.of(context).pop();
  //                       },
  //                       child: Text("확인"),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             }),
  //           );
  //     }
  //   } else {}
  // }
}
