import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_friend/config/class.dart';
import 'package:food_friend/config/function.dart';
import 'package:food_friend/config/server.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/screens/delivery.dart';
import 'package:food_friend/screens/friends.dart';
import 'package:food_friend/screens/login.dart';
import 'package:food_friend/screens/mkdelivery.dart';
import 'package:food_friend/screens/mkgroup.dart';
import 'package:food_friend/screens/recommendation.dart';
import 'package:food_friend/screens/revise.dart';
import 'package:food_friend/widget/widget.dart';
import 'package:get/get.dart';

List<Mainscreen> homeData = [];

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> allCategories = ['일식', '양식', '한식', '중식', '배달'];
  final String username = Get.arguments[0];
  final String userdep = Get.arguments[1];
  final String userid = Get.arguments[2];

  String selectedCategory = '한식';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'FF에 오신걸 환영합니다!',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(
                Icons.forward,
                color: Colors.white,
              ),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('로그인화면'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          //List Body를 기준으로 Text 설정
                          children: <Widget>[
                            Text('처음으로 돌아가시겠습니까?'),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text('확인'),
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
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
              })
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage('assets/backgd.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/meal.png'),
              ),
              accountName: Text(
                username,
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(
                userdep,
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('홈'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('친구'),
              onTap: () {
                Get.to(() => Friends(), arguments: userid);
              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank_rounded),
              title: Text('맘마 생성'),
              onTap: () {
                print(userid);
                Get.to(() => Mkgroup(), arguments: userid);
              },
            ),
            ListTile(
              leading: Icon(Icons.local_dining),
              title: Text('음식 추천'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => recommendation()));
              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank_rounded),
              title: Text('맘마 수정'),
              onTap: () {
                Get.to(() => ReviseGroup(), arguments: userid);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  getBackgroundImage(selectedCategory),
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Center(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    items: allCategories.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          "             " + value,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      );
                    }).toList(),
                    hint: Text('음식 카테고리 선택'),
                  ),
                ),
                SizedBox(height: ratio.height * 20),
                Expanded(
                  child: FutureBuilder(
                    future: resultData(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                            children: List.generate(
                                homeData.length, (index) => homeData[index]));
                      } else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${snapshot.error}",
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      } else {
                        return ListView(
                            children: List.generate(
                                homeData.length, (index) => homeData[index]));
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getBackgroundImage(String category) {
    switch (category) {
      case '일식':
        return 'assets/japanbg.jpg';
      case '양식':
        return 'assets/westback.jfif';
      case '한식':
        return 'assets/koreaback.jpg';
      case '중식':
        return 'assets/chinaback.jpg';
      case '배달':
        return 'assets/deliveryback.jpg';
      default:
        return 'assets/background.jpg';
    }
  }

  Future<void> resultData() async {
    List<Union> unions = await getFireUnion();
    List<Union> filterData = [];
    for (var union in unions) {
      if (union.type == selectedCategory) {
        filterData.add(union);
      }
    }

    List<Mainscreen> data = [];
    for (var union in filterData) {
      data.add(Mainscreen(
          text1: union.title,
          text2: union.max,
          text3: union.time,
          text4: union.place,
          text5: '참가',
          text6: union.number,
          onpressed: (){
            int num = int.parse(union.number) + 1;
            if(num > int.parse(union.max)){
              showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('인원 초과'),
                  content: Text('인원이 다 찼습니다!'),
                );
              },
            );

            // 1초 후에 다이얼로그를 자동으로 닫음
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pop();
            });
            }else{
              String number = num.toString();
              enterUnion(union.place, union.title, number);
              Get.back();
            }
          },
          ),);
    }
    homeData = data;
  }
}
