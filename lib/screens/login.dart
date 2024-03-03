import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_friend/config/class.dart';
import 'package:food_friend/config/function.dart';
import 'package:food_friend/config/server.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/screens/signup.dart';
import 'package:food_friend/screens/home.dart';
import 'dart:io';
import 'package:get/get.dart';


class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
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
        body: GestureDetector(
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
                                            builder: (context) => signup()));
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
                                onPressed: () {
                                  getData();
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

  void getData() async {
    List<FFUser> users = await getFireModels();
    bool loginState = false;
    if (_formkey.currentState!.validate()) {
      for (var user in users) {
        if (_idController.text == user.id && _pwController.text == user.password) {
          loginState = true;
          Get.to(() => Home(), arguments: [user.name, user.dep, user.id]);
          break;
        }
      }
      if(loginState == false){
        showDialog(
              context: context,
              barrierDismissible: true,
              builder: ((context) {
                return AlertDialog(
                  title: Text("로그인 오류"),
                  content: Text("로그인 정보를 확인해주세요."),
                  actions: <Widget>[
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("확인"),
                      ),
                    ),
                  ],
                );
              }),
            );
      }
    } else {}
  }
}
