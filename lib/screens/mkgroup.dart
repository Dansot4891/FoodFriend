import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/config/class.dart';
import 'package:food_friend/config/custom_dialog.dart';
import 'package:food_friend/config/firebase_instance.dart';
import 'package:food_friend/config/validator.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/widget/custom_textfield.dart';

class MakeGroupScreen extends ConsumerStatefulWidget {
  @override
  MakeGroupScreenState createState() => MakeGroupScreenState();
}

class MakeGroupScreenState extends ConsumerState<MakeGroupScreen> {
  GlobalKey<FormState> gkey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _maxController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  final valueList = ['한식', '일식', '중식', '양식', '배달'];

  String food = '한식';

  final inputFormatter = <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('맘마 만들기', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.forward, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/lunch.png'),
              Form(
                key: gkey,
                child: Column(
                  children: [
                    CustomTextField(controller: _titleController, hintText: '제목을 입력해주세요.', validator: titleValidator,),
                    CustomTextField(controller: _maxController, hintText: '최대 인원을 입력해주세요.', validator: maxValidator, inputFormatter: inputFormatter,),
                    CustomTextField(controller: _timeController, hintText: '시간대를 입력해주세요.', validator: timeValidator,),
                    CustomTextField(controller: _placeController, hintText: '만날 장소를 입력해주세요.', validator: placeValidator,),
                    SizedBox(height:ratio.height* 30,),
                    Text('선정하신 음식의 카테고리를 선택해주세요.',style: TextStyle(fontSize: 16),),
                    DropdownButton(
                      value: food,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: valueList.map((String val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(val),
                          );
                      }).toList(),
                      onChanged: (String? val){
                        setState(() {
                          food = val!;
                        });
                      })
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if(gkey.currentState!.validate()){
                    CustomDialog(context: context, title: '맘마팀을 생성하시겠습니까?', buttonText: '확인', buttonCount: 2, func: (){
                      Navigator.pop(context);
                    });
                    //makeGroup();
                  }
                },
                child: Text('만들기', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void makeGroup() async{
    
    String title = _titleController.text;
    String max = _maxController.text;
    String time = _timeController.text;
    String place = _placeController.text;
    String type = food;

    await firestoreInstance.collection('union').doc().set(
      Union(type: type, title: title, max: max, number: '1', time: time, place: place, userid: 'asd').toJson());
    Navigator.pop(context);
  }
}

