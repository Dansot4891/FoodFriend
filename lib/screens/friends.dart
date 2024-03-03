import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_friend/config/server.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/config/class.dart';
import 'package:get/get.dart';

class Friends extends StatefulWidget {
  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  List<String> friends = [];
  String userid = Get.arguments;
  bool isloading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '친구',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: IconButton(
              icon: Icon(
                Icons.forward,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: Row(children: [
                Text('친구들',
                    style: TextStyle(fontSize: 24, color: Colors.black)),
                SizedBox(width: ratio.width * 190),
                ElevatedButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('친구추가'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  TextField(
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                        labelText: '아이디를 입력해주세요.'),
                                  ),
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
                                  print(friends);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '친구추가',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ))
              ])),
          Divider(
            color: Colors.black,
            thickness: 2.0,
          ),
          FutureBuilder<void>(
              future: getFriends(userid),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: friends.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return friend(friedname: friends[index]);
                      });
                } else if (snapshot.hasError) {
                  return Text(
                    "${snapshot.error}",
                    style: TextStyle(fontSize: 15),
                  );
                } else {
                  return ListView.builder(
                      itemCount: friends.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return friend(friedname: friends[index]);
                      });
                }
              }))
        ],
      ),
    );
  }

  Future<void> getFriends(String userid) async {
    List<FFUser> users = await getFireModels();
    print(users);
    List<String> myfriends = [];
    List<String> friendname = [];
    for(var user in users){
      if(user.id == userid){
        myfriends = List<String>.from(friends);
      }
    }
    friends = myfriends;
    // users.clear();
    // users = await getFireModels();
    // for(var user in users){
    //   for(var friendid in myfriends){
    //     if(user.id == friendid){
    //       friendname.add(user.name);
    //     }
    //   }
    // }
    // friends = friendname;
  }
}

class friend extends StatelessWidget {
  final String friedname;
  const friend({
    required this.friedname,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Image.asset('assets/meal.png',
              width: ratio.width * 40, height: ratio.height * 40),
          SizedBox(width: ratio.width * 10),
          Text(
            friedname,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(width: ratio.width * 210),
          Icon(Icons.message),
          SizedBox(width: ratio.width * 10),
          Icon(Icons.call)
        ],
      ),
    );
  }
}
