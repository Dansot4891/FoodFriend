import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/provider/union_provider.dart';
import 'package:food_friend/provider/user_provider.dart';
import 'package:food_friend/screens/unioninfo.dart';
import 'package:food_friend/widget/union_box.dart';

// 함수 호출 시 상태 변경을 알리기 위한 StatefulWidget 클래스
class ReviseScreen extends ConsumerWidget {
  // List<Mainscreen> myData = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(myUnionProvider(ref.watch(UserProvider).id));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '맘마 수정',
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
            }),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_){
                return UnionInfoScreen(data: data[index],);
              }));
            },
            child: UnionBox(buttonText: '삭제', title: data[index].title, dep: data[index].dep, max: data[index].max, num: data[index].num, time: data[index].time, place: data[index].place, func: () async {
              ref.read(unionProvider.notifier).deleteData(data[index], context);
            })
            );
        },
      ),
    );
  }
}
