import 'package:flutter/material.dart';
import 'package:food_friend/main.dart';

class Mainscreen extends StatelessWidget {
  Mainscreen({
    // required this.image,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.color,
  });

  // final Widget image;
  final Widget text1;
  final Widget text2;
  final Widget text3;
  final Widget text4;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text1,
              text2,
              text3,
            ],
          ),
          SizedBox(width: ratio.width*20),
          ElevatedButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: true, // 다이얼로그 이외의 바탕 누르면 꺼지도록 설정
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('참가'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('참가하시겠습니까?'),
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
            child: text4,
            style: ElevatedButton.styleFrom(
              primary: color,
            ),
          )
        ],
      ),
    );
  }
}
