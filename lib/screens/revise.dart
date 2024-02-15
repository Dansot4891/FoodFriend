import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_friend/config/class.dart';
import 'package:food_friend/config/server.dart';
import 'package:food_friend/screens/unioninfo.dart';
import 'package:food_friend/widget/widget.dart';
import 'package:get/get.dart';

// 함수 호출 시 상태 변경을 알리기 위한 StatefulWidget 클래스
class ReviseGroup extends StatefulWidget {
  @override
  _ReviseGroupState createState() => _ReviseGroupState();
}

class _ReviseGroupState extends State<ReviseGroup> {
  List<Mainscreen> myData = [];
  final String myid = Get.arguments;

  @override
  void initState() {
    super.initState();
    MyUnions();
  }

  Future<void> deleteAndRefresh(String title) async {
    await deleteCollection('union', 'userid', myid, 'title', title);
    MyUnions();
  }

  Future<void> MyUnions() async {
    List<Union> unions = await getFireUnion();
    List<Union> filteredUnions = [];

    for (var union in unions) {
      if (union.userid == myid) {
        filteredUnions.add(union);
      }
    }

    List<Mainscreen> data = [];
    for (var union in filteredUnions) {
      data.add(
        Mainscreen(
          text1: Text(
            union.title,
            style: TextStyle(fontSize: 20),
          ),
          text2: Text(
            "인원 : " + union.max + " / " + union.number,
            style: TextStyle(fontSize: 14),
          ),
          text3: Text(
            "시간 : " + union.time,
            style: TextStyle(fontSize: 14),
          ),
          text4: Text(
            "장소 : " + union.place,
            style: TextStyle(fontSize: 14),
          ),
          text5: "삭제",
          onpressed: () {
            deleteAndRefresh(union.title);
            setState(() {
              myData = data;
            });
            Navigator.pop(context);
          },
        ),
      );
    }
    setState(() {
      myData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView.builder(
        itemCount: myData.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Get.to(() => UnionInfo(), arguments: [myid, myData[index]]);
              print(myData[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black
                  )
                )
              ),
              child: myData[index])
            );
        },
      ),
    );
  }
}
