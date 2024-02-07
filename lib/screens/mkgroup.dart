import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_friend/main.dart';

class Mkgroup extends StatefulWidget {
  @override
  State<Mkgroup> createState() => _MkgroupState();
}

class _MkgroupState extends State<Mkgroup> {
  final valueList = ['한식', '일식', '중식', '양식'];

  late var food = '한식';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('맘마 만들기'),
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
              Image.asset('assets/lunch.png'),
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
                    SizedBox(height:ratio.height* 30,),
                    Text('선정하신 음식의 카테고리를 선택해주세요.',style: TextStyle(fontSize: 16),),
                    DropdownButton(
                      alignment: AlignmentDirectional.topStart,
                      value: food,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: valueList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          food = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      '맘마팀이 생성됐습니다.',
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

