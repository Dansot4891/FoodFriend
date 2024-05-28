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
          unionRow(
              icon: Icon(Icons.star_border_outlined),
              text: '방장 ID : ${union.userid}'),
          unionRow(
              icon: Icon(Icons.badge_outlined), text: '방장 학과 : ${union.dep}'),
          unionRow(
              icon: Icon(Icons.groups_outlined),
              text: "인원 : " + union.num + " / " + union.max),
          unionRow(
              icon: Icon(Icons.face),
              text: "참가 인원 : ${union.users.join(', ')}"),
          unionRow(
              icon: Icon(Icons.schedule_outlined), text: "시간 : " + union.time),
          unionRow(
              icon: Icon(Icons.pin_drop_outlined), text: "장소 : " + union.place),
        ],
      ),
    );
  }

  Row unionRow({
    required Icon icon,
    required String text,
  }) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: ratio.width * 5,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
