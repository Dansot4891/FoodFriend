import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/provider/recommend_provider.dart';
import 'package:food_friend/provider/union_provider.dart';
import 'package:food_friend/provider/user_provider.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.abc)),
      ),
      body: Center(
        child: TextButton(onPressed: () async {
          //ref.read(UserProvider.notifier).testFunc();
          //ref.read(unionProvider.notifier).testFunc('eXJ9W4vM2Pxymy12cnfN');
          ref.read(recommendProvider.notifier).makeData();
        }, child: Text('버튼')),
      ),
    );
  }
}