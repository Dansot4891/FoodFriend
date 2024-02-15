import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_friend/config/class.dart';
import 'package:food_friend/config/function.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/screens/home.dart';
import 'package:get/get.dart';

class Mkgroup extends StatefulWidget {
  @override
  State<Mkgroup> createState() => _MkgroupState();
}

class _MkgroupState extends State<Mkgroup> {
  GlobalKey<FormState> gkey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _maxController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  final valueList = ['한식', '일식', '중식', '양식', '배달'];

  final String userid = Get.arguments;
  String food = '한식';

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
              SizedBox(height: 30,),
              Image.asset('assets/lunch.png'),
              Container(
                padding: EdgeInsets.all(30),
                child: Form(
                  key: gkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: titleValidator,
                        controller: _titleController,
                        autofocus: true,
                        decoration: InputDecoration(labelText: '제목을 입력해주세요.'),
                        keyboardType: TextInputType.text,
                      ),
                      TextFormField(
                        validator: maxValidator,
                        controller: _maxController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        autofocus: true,
                        decoration: InputDecoration(labelText: '인원을 설정해주세요'),
                        keyboardType: TextInputType.text,
                      ),
                      TextFormField(
                        validator: timeValidator,
                        controller: _timeController,
                        autofocus: true,
                        decoration: InputDecoration(labelText: '시간대를 입력해주세요.'),
                        keyboardType: TextInputType.text,
                      ),
                      TextFormField(
                        validator: placeValidator,
                        controller: _placeController,
                        autofocus: true,
                        decoration: InputDecoration(labelText: '만나실 장소를 입력해주세요.'),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 20,),
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
              ),
              ElevatedButton(
                onPressed: () {
                  if(gkey.currentState!.validate()){
                    showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        content: Text('맘마팀을 생성하시겠습니까?'),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                            onPressed: (){
                              makeGroup();
                          },
                          child: Text('예')),
                          SizedBox(width: 10,),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                          },
                          child: Text('아니오'))
                            ],
                          )
                        ],
                      );
                    }
                  );
                  }
                },
                child: Text('만들기', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void makeGroup() async{
    
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String title = _titleController.text;
    String max = _maxController.text;
    String time = _timeController.text;
    String place = _placeController.text;
    String type = food;

    await _firestore.collection('union').doc().set(
      Union(type: type, title: title, max: max, number: '1', time: time, place: place, userid: userid).toJson());
    Navigator.pop(context);
    // Get.to(() => Home(), arguments: userid);
  }
}

