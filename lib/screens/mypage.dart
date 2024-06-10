import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/widget/custom_button.dart';
import 'package:food_friend/widget/custom_dialog.dart';
import 'package:food_friend/config/validator.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/model/user_model.dart';
import 'package:food_friend/provider/gender_provider.dart';
import 'package:food_friend/provider/user_provider.dart';
import 'package:food_friend/widget/custom_radio.dart';
import 'package:food_friend/widget/custom_textfield.dart';

enum Sex { male, femail }

class MyPageScreen extends ConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppUser user = ref.watch(UserProvider);
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    TextEditingController _nameController =
        TextEditingController(text: user.name);
    TextEditingController _idController = TextEditingController(text: user.id);
    TextEditingController _pwController = TextEditingController();
    TextEditingController _pw2Controller = TextEditingController();
    TextEditingController _depController =
        TextEditingController(text: user.dep);
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
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '이름',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: ratio.height * 5,
                      ),
                      CustomTextField(
                        controller: _nameController,
                        hintText: '이름을 입력해주세요.',
                        validator: nameValidator,
                      ),
                      SizedBox(
                        height: ratio.height * 25,
                      ),
                      Text(
                        '아이디',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: ratio.height * 5,
                      ),
                      CustomTextField(
                        controller: _idController,
                        hintText: '아이디를 입력해주세요.',
                        validator: idValidator,
                      ),
                      // _userEmail(),
                      SizedBox(
                        height: ratio.height * 25,
                      ),
                      Text(
                        '비밀번호',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: ratio.height * 5,
                      ),
                      CustomTextField(
                        controller: _pwController,
                        hintText: '현재 비밀번호를 입력해주세요.',
                        validator: pwValidator,
                        obscure: true,
                      ),
                      SizedBox(
                        height: ratio.height * 5,
                      ),
                      CustomTextField(
                        controller: _pw2Controller,
                        hintText: '새 비밀번호를 입력해주세요.',
                        validator: pwValidator,
                        obscure: true,
                      ),
                      SizedBox(
                        height: ratio.height * 25,
                      ),
                      Text(
                        '학과',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      CustomTextField(
                        controller: _depController,
                        hintText: '학과를 입력해주세요.',
                        validator: depValidator,
                      ),
                      SizedBox(
                        height: ratio.height * 40,
                      ),
                      Text(
                        '성별을 체크해주세요.',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: ratio.height * 10,
                      ),
                      CustomRadio(),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Spacer(),
                  CustomButton(
                      text: '변경하기',
                      horizonMargin: 20,
                      func: () {
                        if (_formkey.currentState!.validate()) {
                            AppUser userData = AppUser(
                                dep: _depController.text,
                                id: _idController.text,
                                name: _nameController.text,
                                sex: ref.watch(genderProvider),
                                password: _pw2Controller.text);
                            ref.read(UserProvider.notifier).ChangeUserData(user: userData, context: context, ref: ref, nowPw: _pwController.text);

                        } else {}
                      }),
                  SizedBox(
                    height: ratio.height * 30,
                  ),
                ],
              ),
            )
          ],
        ));
  }

}
