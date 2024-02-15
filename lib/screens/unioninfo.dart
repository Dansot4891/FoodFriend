import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_friend/config/class.dart';
import 'package:food_friend/config/function.dart';
import 'package:food_friend/config/server.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/widget/widget.dart';
import 'package:get/get.dart';

class UnionInfo extends StatefulWidget {
  UnionInfo({super.key});

  @override
  State<UnionInfo> createState() => _UnionInfoState();
}

class _UnionInfoState extends State<UnionInfo> {
  final String myid = Get.arguments[0];

  Mainscreen myData = Get.arguments[1];

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController newtitle = TextEditingController();

  TextEditingController max = TextEditingController();

  TextEditingController place = TextEditingController();

  TextEditingController time = TextEditingController();

  final valueList = ['한식', '일식', '중식', '양식', '배달'];

  String type = Get.arguments[2];

  @override
  void initState() {
    super.initState();
    newtitle = TextEditingController(text: myData.text1);
    max = TextEditingController(text: myData.text2);
    place = TextEditingController(text: myData.text3);
    time = TextEditingController(text: myData.text4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '맘마 수정',
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('제목', style: TextStyle(fontSize: 20)),
                TextFormField(
                  validator: titleValidator,
                  controller: newtitle,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: ratio.height * 30,
                ),
                Text('인원', style: TextStyle(fontSize: 20)),
                TextFormField(
                  validator: maxValidator,
                  controller: max,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  autofocus: true,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: ratio.height * 30,
                ),
                Text('시간대', style: TextStyle(fontSize: 20)),
                TextFormField(
                  validator: timeValidator,
                  controller: time,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: ratio.height * 30,
                ),
                Text('장소', style: TextStyle(fontSize: 20)),
                TextFormField(
                  validator: placeValidator,
                  controller: place,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: ratio.height * 40,
                ),
                Center(
                  child: Text(
                    '카테고리',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: ratio.height * 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          type = "한식";
                        });
                      },
                      child: Container(
                        width: ratio.width * 75,
                        height: ratio.height * 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: type == "한식" ? Colors.black.withOpacity(0.3) : Colors.black),
                        child: Center(
                            child: Text(
                          valueList[0],
                          style: TextStyle(color: type == "한식" ? Colors.black : Colors.white, fontSize: 20),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: ratio.width * 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          type = "일식";
                        });
                      },
                      child: Container(
                        width: ratio.width * 75,
                        height: ratio.height * 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: type == "일식" ? Colors.black.withOpacity(0.3) : Colors.black),
                        child: Center(
                            child: Text(
                          valueList[1],
                          style: TextStyle(color: type == "일식" ? Colors.black : Colors.white, fontSize: 20),
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ratio.height * 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          type = "중식";
                        });
                      },
                      child: Container(
                        width: ratio.width * 75,
                        height: ratio.height * 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: type == "중식" ? Colors.black.withOpacity(0.3) : Colors.black),
                        child: Center(
                            child: Text(
                          valueList[2],
                          style: TextStyle(color: type == "중식" ? Colors.black : Colors.white, fontSize: 20),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: ratio.width * 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          type = "양식";
                        });
                      },
                      child: Container(
                        width: ratio.width * 75,
                        height: ratio.height * 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: type == "양식" ? Colors.black.withOpacity(0.3) : Colors.black),
                        child: Center(
                            child: Text(
                          valueList[3],
                          style: TextStyle(color: type == "양식" ? Colors.black : Colors.white, fontSize: 20),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: ratio.width * 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          type = "배달";
                        });
                      },
                      child: Container(
                        width: ratio.width * 75,
                        height: ratio.height * 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: type == "배달" ? Colors.black.withOpacity(0.3) : Colors.black),
                        child: Center(
                            child: Text(
                          valueList[4],
                          style: TextStyle(color: type == "배달" ? Colors.black : Colors.white, fontSize: 20),
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ratio.height * 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            updateUnionByName(myid, myData.text1, newtitle.text,
                              max.text, place.text, time.text, type);
                              Navigator.pop(context);
                          }else{}
                        },
                        child: Text(
                          '수정하기',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
