import 'package:flutter/material.dart';
import 'package:food_friend/config/custom_dialog.dart';
import 'package:food_friend/main.dart';

class UnionBox extends StatelessWidget {
  
  final String title;
  final String dep;
  final String max;
  final String num;
  final String time;
  final String place;
  final String buttonText;
  final VoidCallback func;

  UnionBox({
    required this.title,
    required this.dep,
    required this.max,
    required this.num,
    required this.time,
    required this.place,
    required this.func,
    this.buttonText = '참가',
  });

  

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
                  title,
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Icon(Icons.badge_outlined),
                    SizedBox(width: ratio.width * 5,),
                    Text('학과 : ${dep}', style: TextStyle(fontSize: 14),),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.groups_outlined),
                    SizedBox(width: ratio.width * 5,),
                    Text(
                      "인원 : " + max + " / " + num,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.schedule_outlined),
                    SizedBox(width: ratio.width * 5,),
                    Text(
                      "시간 : " + time,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.pin_drop_outlined),
                    SizedBox(width: ratio.width * 5,),
                    Text(
                      "장소 : " + place,
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: ratio.width * 20),
          ElevatedButton(
            onPressed: () {
              CustomDialog(context: context, title: '${buttonText}하시겠습니까?', buttonText: '확인', buttonCount: 2, func: func);
            },
            child: Text(
              buttonText,
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
