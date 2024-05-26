import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_friend/config/custom_button.dart';
import 'package:food_friend/config/custom_dialog.dart';
import 'package:food_friend/config/firebase_instance.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/widget/custom_textfield.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userIdController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('신고하기'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: ratio.height * 50,),
            Text('지속적으로 노쇼하는 인원들을 신고하여 주세요.', style: TextStyle(fontSize: 16,), textAlign: TextAlign.center,),
            SizedBox(height: ratio.height * 20,),
            Text('반복적으로 노쇼에 대한 신고가 들어오는 유저에 대해서 제재가 이루어집니다.', style: TextStyle(fontSize: 16,), textAlign: TextAlign.center,),
            SizedBox(height: ratio.height * 30,),
            Text('※악의적, 반복적으로 타인을 신고하는\n 행위에 대하여 제재가 가해질 수 있습니다.', style: TextStyle(fontSize: 16, color: Colors.grey), textAlign: TextAlign.center,),
            SizedBox(height: ratio.height * 30,),
            CustomTextField(controller: userIdController, hintText: '신고하시려는 유저의 ID를 입력해주세요.'),
            SizedBox(height: ratio.height * 30,),
            CustomButton(text: '신고하기', func: () async {
              try{
                final data = {'userId' : userIdController.text};
                await firestoreInstance.collection('report').doc().set(data);
                CustomDialog(context: context, title: '신고가 완료되었습니다!', buttonText: '확인', buttonCount: 1, func: (){Navigator.pop(context);});
              }catch(e){
                CustomDialog(context: context, title: '예기치 못한 오류가 발생하였습니다.\n다시 시도하여 주세요.', buttonText: '확인', buttonCount: 1, func: (){Navigator.pop(context);});
                print(e);
              }
            }),
          ],
        ),
      ),
    );
  }
}