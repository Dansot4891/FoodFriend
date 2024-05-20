import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/provider/gender_provider.dart';

class CustomRadio extends ConsumerWidget {
  const CustomRadio({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String gender = ref.watch(genderProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomRatdioButton(text: '남자', func: (){
          ref.read(genderProvider.notifier).setGender('남자');
        }, color1: gender == '남자' ? Colors.black : Colors.white, color2: gender == '남자' ? Colors.white : Colors.black,),
        CustomRatdioButton(text: '여자', func: (){
          ref.read(genderProvider.notifier).setGender('여자');
        }, color1: gender == '여자' ? Colors.black : Colors.white, color2: gender == '여자' ? Colors.white : Colors.black,),
        SizedBox()
      ],
    );
  }

  InkWell CustomRatdioButton({
    required String text,
    required VoidCallback func,
    Color color1 = Colors.black,
    Color color2 = Colors.white,
  }){
    return InkWell(
      onTap: func,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: ratio.width * 30,
              height: ratio.height * 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
                color: color1,
              ),
              child: Icon(
                Icons.check,
                color: color2,
              ),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
    );
  }
}
