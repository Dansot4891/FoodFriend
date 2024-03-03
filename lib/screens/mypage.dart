import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_friend/config/function.dart';
import 'package:food_friend/config/server.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/screens/login.dart';
import 'package:food_friend/config/class.dart';
import 'package:get/get.dart';

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

enum Sex { male, femail }

class _MyPageState extends State<MyPage> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _depController = TextEditingController();
  FFUser mydata = Get.arguments;

  late String id;
  Sex? _sex = Sex.male;
  String? pw;
  String? pwcheck;

  bool nameEnable = false;
  bool idEnable = false;
  bool pwEnable = false;
  bool depEnable = false;

  @override
  void initState() {
    super.initState();
    id = mydata.id;
    _sex = mydata.sex == "남자" ? Sex.male : Sex.femail;
    _nameController = TextEditingController(text: mydata.name);
    _idController = TextEditingController(text: mydata.id);
    _pwController = TextEditingController(text: mydata.password);
    _depController = TextEditingController(text: mydata.dep);
  }

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
                        SizedBox(
                          height: ratio.height * 5,
                        ),
                        Row(
                          children: [
                            Expanded(child: _userName()),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    nameEnable = true;
                                  });
                                },
                                icon: Icon(Icons.edit))
                          ],
                        ),
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
                        Row(
                          children: [
                            Expanded(child: _userId()),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    idEnable = true;
                                  });
                                },
                                icon: Icon(Icons.edit))
                          ],
                        ),
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
                        Row(
                          children: [
                            Expanded(child: _userPw()),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    pwEnable = true;
                                  });
                                },
                                icon: Icon(Icons.edit))
                          ],
                        ),
                        SizedBox(
                          height: ratio.height * 10,
                        ),
                        Text(
                          '학과',
                          style: TextStyle(fontSize: 15),
                        ),
                        Row(
                          children: [
                            Expanded(child: _userDep()),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    depEnable = true;
                                  });
                                },
                                icon: Icon(Icons.edit))
                          ],
                        ),
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
                    onPressed: updateUser,
                    child: Text(
                      '내 정보 변경하기',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
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
      enabled: nameEnable,
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
      enabled: idEnable,
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
      enabled: pwEnable,
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
      enabled: depEnable,
      controller: _depController,
      decoration: const InputDecoration(
        hintText: '학과를 입력해주세요.',
        border: OutlineInputBorder(),
      ),
      validator: depValidator,
    );
  }

  void updateUser() async {
    String userid = _idController.text;
    String userpw = _pwController.text;
    String username = _nameController.text;
    String usersex = _sex == Sex.male ? '남자' : '여자';
    String userdep = _depController.text;
    List<FFUser> users = await getFireModels();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    bool overlap = false;
    if (_formkey.currentState!.validate()) {
      for (var user in users) {
        if (userid == user.id && id != userid) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: ((context) {
              return AlertDialog(
                title: Text("아이디 중복"),
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
      }if(overlap == false) {
          firestore
              .collection('user')
              .where('id', isEqualTo: id)
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              firestore.collection('user').doc(doc.id).update({
                'id': userid,
                'password': userpw,
                'name': username,
                'dep': userdep,
                'sex': usersex,
              }).then((_) {
                showDialog(
            context: context,
            barrierDismissible: true,
            builder: ((context) {
              return AlertDialog(
                title: Text("변경 완료"),
                content: Text("정보가 변경되었습니다.\n다시 로그인 해주세요."),
                actions: <Widget>[
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => Login());
                      },
                      child: Text("확인"),
                    ),
                  ),
                ],
              );
            }),
          );
                print('데이터 업데이트 완료');
              }).catchError((error) {
                print('데이터 업데이트 실패: $error');
              });
            });
          }).catchError((error) {
            print('문서 찾기 실패: $error');
          });
          
        }
    } else {}
  }
}
