import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class mkdelivery extends StatefulWidget {
  @override
  State<mkdelivery> createState() => _mkdeliveryState();
}

class _mkdeliveryState extends State<mkdelivery> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('맘마 배달 만들기'),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
            icon: Icon(Icons.forward),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/baedal.jfif'),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(labelText: '제목을 입력해주세요.'),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(labelText: '인원을 설정해주세요'),
                      keyboardType: TextInputType.text,
                    ),
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(labelText: '음식종류를 입력해주세요.'),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(labelText: '시간대를 입력해주세요.'),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(labelText: '픽업 장소를 입력해주세요.'),
                      keyboardType: TextInputType.text,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      '맘마 배달팀이 생성됐습니다.',
                      textAlign: TextAlign.center,
                    ),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.black,
                  ));
                },
                child: Text('만들기'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  
}

