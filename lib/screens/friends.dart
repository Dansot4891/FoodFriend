import 'package:flutter/material.dart';
import 'package:food_friend/main.dart';

class Friends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('친구', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.forward, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            })
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                Text('친구들',style: TextStyle(fontSize: 24, color: Colors.black)),
                SizedBox(width: ratio.width*190),
                ElevatedButton(
                  onPressed: (){
                    showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('친구추가'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        TextField(
                          autocorrect: false,
                          decoration: InputDecoration(labelText: '아이디를 입력해주세요.'),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('확인'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('취소'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('친구추가', style: TextStyle(color: Colors.white),),
                      Icon(Icons.add, color: Colors.white,)
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ))
                ]
              )),
          Divider(
            color: Colors.black,
            thickness: 2.0,
          ),
        Padding(padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset('assets/meal.png',
            width:ratio.width* 40,
            height: ratio.height*40),
            SizedBox(width: ratio.width*10),
            Text('임명우',
            style: TextStyle(fontSize: 20),),
            SizedBox(width:ratio.width* 210),
            Icon(Icons.message),
            SizedBox(width:ratio.width* 10),
            Icon(Icons.call)
          ],
        ),)
        ],
      ),
    );
  }
}
