import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_friend/screens/login.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

late Size ratio;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
) ;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ratio = Size(MediaQuery.sizeOf(context).width / 400,
                 MediaQuery.sizeOf(context).height / 900);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Myapp',
      home: Login(),
    );
  }
}
