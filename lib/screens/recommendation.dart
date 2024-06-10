import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/widget/custom_button.dart';
import 'package:food_friend/widget/custom_dialog.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/model/recommend_model.dart';
import 'package:food_friend/provider/recommend_provider.dart';
import 'package:food_friend/screens/home.dart';
import 'package:food_friend/screens/mkgroup.dart';

class RecommendationScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends ConsumerState<RecommendationScreen> {
  final valueList = ['한식', '일식', '중식', '양식'];

  @override
  void initState() {
    super.initState();
    ref.read(recommendProvider.notifier).fetchData();
  }

  String selectedCategory = '한식';
  String recommendedFood = '';
  String recommendedFoodImgPath = '';

  @override
  Widget build(BuildContext context) {
    final selectedData = ref.watch(selectedRecommendProvider(selectedCategory));
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          '음식 추천을 추천해드립니다!',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: ratio.height * 20,
            ),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                  recommendedFood = '';
                  recommendedFoodImgPath = '';
                });
              },
              items: valueList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('음식 카테고리 선택'),
            ),
            Spacer(),
            if (recommendedFood.isNotEmpty)
              Text(
                '추천 음식: $recommendedFood',
                style: TextStyle(fontSize: 28),
              ),
            if(recommendedFoodImgPath.isNotEmpty)
              CachedNetworkImage(
                //width: ratio.width * 200,
                //height: ratio.height * 200,
                memCacheHeight: (ratio.height * 200).round(),
                memCacheWidth: (ratio.width * 200).round(),
                imageUrl : recommendedFoodImgPath,
                placeholder : (context, url) => CircularProgressIndicator(),
                errorWidget : (context, url, error) => Icon(Icons.error)
                //Image.network(recommendedFoodImgPath, width: ratio.width * 150,)
              ),
            SizedBox(height: ratio.height * 20),
            CustomButton(
                horizonMargin: 20,
                text: '음식 추천 받기',
                func: () {
                  recommendFood(selectedData);
                }),
                SizedBox(height: ratio.height * 20),
            CustomButton(
                horizonMargin: 20,
                text: '해당 음식 맘마 생성하기',
                func: () {
                  if(recommendedFood.isEmpty){
                    CustomDialog(context: context, title: '음식 추천을 받으신 후\n이용해주세요!', buttonText: '확인', buttonCount: 1, func: (){
                      Navigator.pop(context);
                    });
                    return;
                  }
                  CustomDialog(context: context, title: '해당 음식 맘마 생성으로\n이동하시겠습니까?', buttonText: '확인', buttonCount: 2, func: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                      return MakeGroupScreen(type: selectedCategory, title: '${recommendedFood} 먹으러 갈사람!',);
                    }));
                  });
                }),
                SizedBox(height: ratio.height * 20),
            CustomButton(
                horizonMargin: 20,
                text: '해당 카테고리 맘마 확인하기',
                func: () {
                  if(recommendedFood.isEmpty){
                    CustomDialog(context: context, title: '음식 추천을 받으신 후\n이용해주세요!', buttonText: '확인', buttonCount: 1, func: (){
                      Navigator.pop(context);
                    });
                    return;
                  }
                  CustomDialog(context: context, title: '해당 카테고리로\n이동하시겠습니까?', buttonText: '확인', buttonCount: 2, func: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                      return HomeScreen(category: selectedCategory,);
                    }));
                  });
                }),
                Spacer()
          ],
        ),
      ),
    );
  }

  void recommendFood(List<Recommendation> data) {
    setState(() {
      Random random = Random();
      int index = random.nextInt(data.length);
      recommendedFood = data[index].name;
      recommendedFoodImgPath = data[index].imgPath;
    });
  }
}
