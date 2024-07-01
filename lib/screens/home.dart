import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/widget/custom_dialog.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/model/union_model.dart';
import 'package:food_friend/model/user_model.dart';
import 'package:food_friend/provider/union_provider.dart';
import 'package:food_friend/provider/user_provider.dart';
import 'package:food_friend/screens/login.dart';
import 'package:food_friend/screens/mkgroup.dart';
import 'package:food_friend/screens/mypage.dart';
import 'package:food_friend/screens/recommendation.dart';
import 'package:food_friend/screens/report.dart';
import 'package:food_friend/screens/revise.dart';
import 'package:food_friend/screens/test.dart';
import 'package:food_friend/widget/union_box.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String? category;
  HomeScreen({
    Key? key,
    this.category = null,
  });

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      selectedCategory = widget.category!;
    }
    ref.read(unionProvider.notifier).getData();
  }

  final List<String> allCategories = ['전체', '일식', '양식', '한식', '중식', '배달'];
  String selectedCategory = '전체';

  @override
  Widget build(BuildContext context) {
    final AppUser user = ref.watch(UserProvider);
    final unionData = ref.watch(unionSelectedProvider(selectedCategory));

    if (ref.watch(unionSelectedProvider("전체")).length == 0)
      return homeLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
        user: user,
      );

    return homeLayout(
      child: Padding(
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
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            SizedBox(height: ratio.height * 20),
            Expanded(
                child: ListView.separated(
              itemCount: unionData.length,
              itemBuilder: (context, index) {
                return UnionBox(
                    //buttonText: isEnter(team: unionData[index], id : user.id),
                    union: unionData[index],
                    func: () async {
                      for (var enteredUser in unionData[index].users) {
                        if (enteredUser == user.id) {
                          CustomDialog(
                              context: context,
                              title: '이미 참가하신 팀입니다.',
                              buttonText: '확인',
                              buttonCount: 1,
                              func: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                          return;
                        }
                      }
                      ref.read(unionProvider.notifier).EnterUnion(
                          union: unionData[index],
                          context: context,
                          userid: user.id);
                    });
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )),
          ],
        ),
      ),
      user: user,
    );
  }

  Scaffold homeLayout({
    required Widget child,
    required AppUser user,
  }) {
    return Scaffold(
        backgroundColor: Color(0xFFFDFDFD),
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
                  CustomDialog(
                      context: context,
                      title: '로그아웃 하시겠습니까?',
                      buttonText: '확인',
                      buttonCount: 2,
                      func: () {
                        ref.read(UserProvider.notifier).LogoutFunc();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => Login()));
                      });
                })
          ],
        ),
        drawer: DrawerWidget(user: user),
        body: child);
  }

  String isEnter({required UnionModel team, required String id}) {
    String entered = '참가';
    for (dynamic userId in team.users) {
      if (userId == id) {
        entered = '취소';
      }
    }
    return entered;
  }

  Drawer DrawerWidget({required AppUser user}) {
    return Drawer(
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
              user.name,
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              user.dep,
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
            title: Text('내 정보'),
            onTap: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MyPageScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.food_bank_rounded),
            title: Text('맘마 생성'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MakeGroupScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.local_dining),
            title: Text('음식 추천'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecommendationScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.food_bank_rounded),
            title: Text('맘마 수정'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReviseScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.report),
            title: Text('신고하기'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReportScreen()));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.report),
          //   title: Text('Test'),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => TestPage()));
          //   },
          // ),
        ],
      ),
    );
  }
}
