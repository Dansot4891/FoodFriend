import 'package:flutter/material.dart';
import 'package:food_friend/main.dart';

class delivery extends StatefulWidget {
  const delivery({super.key});

  @override
  State<delivery> createState() => _deliveryState();
}


class _deliveryState extends State<delivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FF 배달음식', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.forward, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/recomend.png'),
              fit: BoxFit.cover,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Subscreen(
                    image:
                        Image.asset('assets/burger.jfif', width: ratio.width*150, height: ratio.height*150),
                    text1: Text('햄버거 ㄱ?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                    text2: Text('현재 인원 : 1/4', style: TextStyle(fontSize: 14)),
                    text3: Text('음식 종류 : 양식', style: TextStyle(fontSize: 14)),
                    text4: Text('시간 : 18:00 ~ 18:30',
                        style: TextStyle(fontSize: 14)),
                    text6: Text('픽업 장소 : 가천관 정문', style: TextStyle(fontSize: 14)),
                    text5: Text('참가'),
                    color: Colors.black),
                Divider(thickness: 1.5),
                Subscreen(
                    image:
                        Image.asset('assets/bbq.jfif', width:ratio.width* 150, height: ratio.height*150),
                    text1: Text('bbq 나눠 먹자', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
                    text2: Text('현재 인원 : 1/2', style: TextStyle(fontSize: 14)),
                    text3: Text('음식 종류 : 치킨', style: TextStyle(fontSize: 14)),
                    text4: Text('시간 : 17:00',
                        style: TextStyle(fontSize: 14)),
                    text6: Text('픽업 장소 : 복정역 2출', style: TextStyle(fontSize: 14)),
                    text5: Text('참가'),
                    color: Colors.black),
                Divider(thickness: 1.5),
                
              ],
            ),
          ),
      )
    );
  }
}


class Subscreen extends StatelessWidget {
  Subscreen({
    required this.image,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.text6,
    required this.color,
  });

  final Widget image;
  final Widget text1;
  final Widget text2;
  final Widget text3;
  final Widget text4;
  final Widget text5;
  final Widget text6;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        image,
        SizedBox(width:ratio.width* 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text1,
            text2,
            text3,
            text4,
            text6,
          ],
        ),
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
                      //List Body를 기준으로 Text 설정
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
          child: text5,
          style: ElevatedButton.styleFrom(
            primary: color,
          ),
        )
      ],
    );
  }
}
