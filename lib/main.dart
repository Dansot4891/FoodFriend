import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/screens/login.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

late Size ratio;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
) ;
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ratio = Size(MediaQuery.sizeOf(context).width / 412,
                 MediaQuery.sizeOf(context).height / 892); 
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Myapp',
      home: Login(),
    );
  }
}
