import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/config/custom_dialog.dart';
import 'package:food_friend/config/validator.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/model/user_model.dart';
import 'package:food_friend/provider/user_provider.dart';
import 'package:food_friend/widget/custom_textfield.dart';

class SignupScreen extends ConsumerStatefulWidget {
  @override
  SignupScreenState createState() => SignupScreenState();
}

enum Sex { male, femail }

class SignupScreenState extends ConsumerState<SignupScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _pwCheckController = TextEditingController();
  final TextEditingController _depController = TextEditingController();

  Sex? _sex = Sex.male;

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
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                      CustomTextField(
                        controller: _nameController,
                        hintText: '이름을 입력해주세요',
                        validator: nameValidator,
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
                      CustomTextField(
                        controller: _idController,
                        hintText: '5~20자의 숫자/영문/특수기호 아이디',
                        validator: idValidator,
                      ),
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
                      CustomTextField(
                        controller: _pwController,
                        hintText: '8~16자의 숫자/영문/특수기호 비밀번호',
                        validator: pwValidator,
                        obscure: true,
                      ),
                      SizedBox(
                        height: ratio.height * 10,
                      ),
                      CustomTextField(
                        controller: _pwCheckController,
                        hintText: '비밀번호를 재입력헤주세요.',
                        validator: pwValidator,
                        obscure: true,
                      ),
                      SizedBox(
                        height: ratio.height * 15,
                      ),
                      Text(
                        '학과',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: ratio.height * 5,
                      ),
                      CustomTextField(
                        controller: _depController,
                        hintText: '학과를 입력해주세요. ex) 경영학과',
                        validator: depValidator,
                      ),
                      SizedBox(
                        height: ratio.height * 30,
                      ),
                      Text(
                        '성별을 체크해주세요.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
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
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        AppUser user = AppUser(
                            dep: _depController.text,
                            password: _pwController.text,
                            id: _idController.text,
                            name: _nameController.text,
                            sex: _sex == Sex.male ? '남자' : '여자');
                        if (_formkey.currentState!.validate()) {
                          if (_pwController.text != _pwCheckController.text) {
                            CustomDialog(
                                context: context,
                                title: '비밀번호가 같은지 확인해주세요.',
                                buttonText: '확인',
                                buttonCount: 1,
                                func: () {
                                  Navigator.pop(context);
                                });
                          } else {
                            ref.read(UserProvider.notifier).signUpFunc(user: user, context: context);
                          }
                        }
                      },
                      child: Text(
                        '회원가입하기',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          minimumSize: const Size.fromHeight(0),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
