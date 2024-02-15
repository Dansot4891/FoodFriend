import 'package:flutter/material.dart';
import 'package:food_friend/widget/widget.dart';
import 'package:get/get.dart';

class UnionInfo extends StatelessWidget {
  UnionInfo({super.key});

  final String myid = Get.arguments[0];
  Mainscreen myData = Get.arguments[1];
  // final List<Mainscreen> myData = Get.arguments[1];

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('제목 : '),
                myData.text1
              ],
            ),
            myData.text2,
            myData.text3,
            myData.text4,
            ElevatedButton(onPressed: (){}, child: Text('수정'))
          ],
        ),
      ),
    );
  }
}
