import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_friend/config/custom_dialog.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/model/union_model.dart';

class UnionBox extends StatelessWidget {
  final UnionModel union;
  final String buttonText;

  final VoidCallback func;

  UnionBox({
    required this.union,
    required this.func,
    this.buttonText = '참가',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                union.title,
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                onPressed: () {
                  CustomDialog(
                      context: context,
                      title: '${buttonText}하시겠습니까?',
                      buttonText: '확인',
                      buttonCount: 2,
                      func: func);
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
          SizedBox(
            height: ratio.height * 5,
          ),
          Row(
            children: [
              Icon(Icons.badge_outlined),
              SizedBox(
                width: ratio.width * 5,
              ),
              Text(
                '방장 학과 : ${union.dep}',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.groups_outlined),
              SizedBox(
                width: ratio.width * 5,
              ),
              Text(
                "인원 : " + union.max + " / " + union.num,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.face),
              SizedBox(
                width: ratio.width * 5,
              ),
              Expanded(
                child: Text(
                  "참가 인원 : ${union.users.join(', ')}",
                  style: TextStyle(fontSize: 14),
                  maxLines: null,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.schedule_outlined),
              SizedBox(
                width: ratio.width * 5,
              ),
              Text(
                "시간 : " + union.time,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.pin_drop_outlined),
              SizedBox(
                width: ratio.width * 5,
              ),
              Text(
                "장소 : " + union.place,
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ],
      ),
    );
  }
}
