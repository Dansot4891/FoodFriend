import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_friend/config/function.dart';
import 'package:food_friend/config/server.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/screens/login.dart';
import 'package:food_friend/config/class.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

enum Sex { male, femail }

class _signupState extends State<signup> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _depController = TextEditingController();

  Sex? _sex = Sex.male;
  String? pw;
  String? pwcheck;

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '회원가입',
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
                        SizedBox(
                          height: ratio.height * 5,
                        ),
                        _userName(),
                        SizedBox(
                          height: ratio.height * 25,
                        ),
                        Text(
                          '아이디',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: ratio.height * 5,
                        ),
                        _userId(),
                        // _userEmail(),
                        SizedBox(
                          height: ratio.height * 25,
                        ),
                        Text(
                          '비밀번호',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: ratio.height * 5,
                        ),
                        _userPw(),
                        SizedBox(
                          height: ratio.height * 10,
                        ),
                        _userPwCheck(),
                        SizedBox(
                          height: ratio.height * 15,
                        ),
                        Text(
                          '학과',
                          style: TextStyle(fontSize: 15),
                        ),
                        _userDep()
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
                          setState(() {
                            _sex = value;
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('여자'),
                        value: Sex.femail,
                        groupValue: _sex,
                        onChanged: (value) {
                          setState(() {
                            _sex = value;
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: signUpComplete,
                    child: Text(
                      '회원가입하기',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userName() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: '이름을 입력해주세요.',
        border: OutlineInputBorder(),
      ),
      validator: nameValidator,
    );
  }

  Widget _userId() {
    return TextFormField(
      controller: _idController,
      decoration: const InputDecoration(
        hintText: '5~20자의 숫자/영문/특수기호 아이디',
        border: OutlineInputBorder(),
      ),
      validator: idValidator,
    );
  }

  Widget _userPw() {
    return TextFormField(
      controller: _pwController,
      onChanged: (val) {
        setState(() {
          pw = val;
        });
      },
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: '8~16자의 숫자/영문/특수기호 비밀번호',
      ),
      validator: pwValidator,
    );
  }

  Widget _userPwCheck() {
    return TextFormField(
      onChanged: (val) {
        setState(() {
          pwcheck = val;
        });
      },
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: '비밀번호를 다시 입력해주세요.',
      ),
      validator: (val) {
        if (val!.length > 16 || val.length < 8) {
          if (val.isEmpty) {
            return '비밀번호를 입력해주세요.';
          }
          return '올바른 비밀번호를 입력해주세요';
        } else if (pw != pwcheck) {
          return '비밀번호를 확인해주세요.';
        } else {
          return null;
        }
      },
    );
  }

  Widget _userDep() {
    return TextFormField(
      controller: _depController,
      decoration: const InputDecoration(
        hintText: '학과를 입력해주세요. ex) 경영학과',
        border: OutlineInputBorder(),
      ),
      validator: depValidator,
    );
  }

  void signUpComplete() async {
    String userid = _idController.text;
    String userpw = _pwController.text;
    String username = _nameController.text;
    String usersex = _sex == Sex.male ? '남자' : '여자';
    String userdep = _depController.text;
    List<FFUser> users = await getFireModels();
    bool overlap = false;
    if (_formkey.currentState!.validate()) {
      for (var user in users) {
        if (userid == user.id) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: ((context) {
              return AlertDialog(
                title: Text("회원가입 오류"),
                content: Text("중복되는 아이디가 존재합니다.\n다른 아이디를 입력해주세요."),
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
          overlap = true;
        }
      }
      if (overlap == false) {
        await _firestore.collection('user').doc().set(
            FFUser(id: userid, password: userpw, name: username, sex: usersex, dep: userdep)
                .toJson());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    } else {}
  }
}
