import 'package:flutter/material.dart';
import 'package:food_friend/main.dart';

class Mainscreen extends StatelessWidget {
  Mainscreen({
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.text6,
    required this.onpressed,
  });

  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "인원 : " + text2 + " / " + text6,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "시간 : " + text3,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  "장소 : " + text4,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(width: ratio.width * 20),
          ElevatedButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(text5),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(text5 + '하시겠습니까?'),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(child: Text('확인'), onPressed: onpressed),
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
            child: Text(
              text5,
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
