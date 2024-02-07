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
import 'package:food_friend/widget/widget.dart';
import 'package:get/get.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> allCategories = ['일식', '양식', '한식', '중식'];
    
  String username = Get.arguments[0];
  String userdep = Get.arguments[1];
  
  Map<String, List<Mainscreen>> categoryToFoodMap = {
    '일식': [
      // Mainscreen(
      //   image: Image.asset('assets/hosikdang.jfif', width:ratio.width* 125, height:ratio.height* 125),
      //   text1: Text('점심 호식당 가실분?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
      //   text2: Text('현재 인원 : 1/3', style: TextStyle(fontSize: 14)),
      //   text3: Text('시간 : 11:00 ~ 12:00', style: TextStyle(fontSize: 14)),
      //   text4: Text('참가',style: TextStyle(color: Colors.white),),
      //   color: Colors.black,
      // ),
      // Mainscreen(
      //   image: Image.asset('assets/Dongas.jfif', width: ratio.width*120, height:ratio.height* 120),
      //   text1: Text('태돈 가실분 있나여?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
      //   text2: Text('현재 인원 : 1/2', style: TextStyle(fontSize: 14)),
      //   text3: Text('시간 : 14:00 ~ 15:00', style: TextStyle(fontSize: 14)),
      //   text4: Text('참가',style: TextStyle(color: Colors.white),),
      //   color: Colors.black,
      // ),
    ],
    '양식': [
      // Mainscreen(
      //   image: Image.asset('assets/pizza.jfif', width: ratio.width*120, height:ratio.height* 120),
      //   text1: Text('2인 피자 ㄲ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
      //   text2: Text('현재 인원 : 1/2', style: TextStyle(fontSize: 14)),
      //   text3: Text('시간 : 14:00 ~ 15:00', style: TextStyle(fontSize: 14)),
      //   text4: Text('참가',style: TextStyle(color: Colors.white),),
      //   color: Colors.black,
      // ),
      // Mainscreen(
      //   image: Image.asset('assets/burger.jfif', width: ratio.width*120, height:ratio.height* 120),
      //   text1: Text('햄버거 땡기는 사람?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
      //   text2: Text('현재 인원 : 1/3', style: TextStyle(fontSize: 14)),
      //   text3: Text('시간 : 17:00 ~ 18:00', style: TextStyle(fontSize: 14)),
      //   text4: Text('참가',style: TextStyle(color: Colors.white),),
      //   color: Colors.black,
      // ),
    ],
    '한식': [
      // Mainscreen(
      //   image: Image.asset('assets/sudae.jfif', width:ratio.width* 120, height:ratio.height* 120),
      //   text1: Text('해장 순대국', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
      //   text2: Text('현재 인원 : 1/4', style: TextStyle(fontSize: 14)),
      //   text3: Text('시간 : 10:00 ~ 11:00', style: TextStyle(fontSize: 14)),
      //   text4: Text('참가',style: TextStyle(color: Colors.white),),
      //   color: Colors.black,
      // ),
      Mainscreen(
        text1: Text('신의 한컵 ㄱㄱ?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
        text2: Text('현재 인원 : ??', style: TextStyle(fontSize: 14)),
        text3: Text('시간 : 11:00 ~ 12:00', style: TextStyle(fontSize: 14)),
        text4: Text('참가',style: TextStyle(color: Colors.white),),
        color: Colors.black,
      ),
      Mainscreen(
          text1: Text('밥버거에 라면 ㄱ?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
          text2: Text('현재 인원 : 1/3', style: TextStyle(fontSize: 14)),
          text3: Text('시간 : 17:30 ~ 18:30', style: TextStyle(fontSize: 14)),
          text4: Text('참가',style: TextStyle(color: Colors.white),),
          color: Colors.black),
    ],
    '중식': [
      // Mainscreen(
      //   image: Image.asset('assets/joong.jfif', width: ratio.width*120, height:ratio.height* 120),
      //   text1: Text('중국집 드실분?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
      //   text2: Text('현재 인원 : ??', style: TextStyle(fontSize: 14)),
      //   text3: Text('시간 : 11:00 ~ 12:00', style: TextStyle(fontSize: 14)),
      //   text4: Text('참가',style: TextStyle(color: Colors.white),),
      //   color: Colors.black,
      // ),
      // Mainscreen(
      //     image: Image.asset('assets/chinaspoon.jfif', width: ratio.width*125, height:ratio.height* 125),
      //     text1: Text('중국집 땡기시는 분?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
      //     text2: Text('현재 인원 : ??', style: TextStyle(fontSize: 14)),
      //     text3: Text('시간 : 13:00 ~ 14:00', style: TextStyle(fontSize: 14)),
      //     text4: Text('참가',style: TextStyle(color: Colors.white),),
      //     color: Colors.black),
    ],
  };

  String selectedCategory = '한식';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('FF에 오신걸 환영합니다!', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: Icon(Icons.forward, color: Colors.white,),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true, // 다이얼로그 이외의 바탕 누르면 꺼지도록 설정
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
                // '임명우',
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Friends()));
              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank_rounded),
              title: Text('맘마 생성'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Mkgroup()));
              },
            ),
            ListTile(
              leading: Icon(Icons.motorcycle),
              title: Text('맘마 배달'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => delivery()));
              },
            ),
            ListTile(
              leading: Icon(Icons.motorcycle_sharp),
              title: Text('맘마 배달 생성'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => mkdelivery()));
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
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(getBackgroundImage(selectedCategory)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: allCategories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    );
                  }).toList(),
                  hint: Text('음식 카테고리 선택'),
                  
                ),
                SizedBox(height:ratio.height* 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: categoryToFoodMap[selectedCategory]!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Card(
                            color: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: categoryToFoodMap[selectedCategory]![index],
                          ),
                          Divider(
                            thickness: 1.5,
                            color: Colors.black,
                          ),
                        ],
                      );
                    },
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
        return 'assets/japanback.jpg';
      case '양식':
        return 'assets/westback.jfif';
      case '한식':
        return 'assets/koreaback.jpg';
      case '중식':
        return 'assets/chinaback2.jpg';
      default:
        return 'assets/background.jpg';
    }
  }

  void getData() async {
    List<Union> unions = await getFireUnion();
      for (var union in unions) {
        if(union.type != selectedCategory){
          unions.remove(union);
        }
      }
      for (var union in unions) {
        if(union.type != selectedCategory){
          unions.remove(union);
        }
      }
  }
}

