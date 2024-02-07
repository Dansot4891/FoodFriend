import 'dart:math';
import 'package:flutter/material.dart';
import 'package:food_friend/main.dart';

class recommendation extends StatefulWidget {
  @override
  State<recommendation> createState() => _recommendationState();
}

class _recommendationState extends State<recommendation> {
  final valueList = ['한식', '일식', '중식', '양식'];

  Map<String, List<String>> categoryToFoodMap = {
    '한식': ['비빔밥', '불고기', '김치찌개', '떡볶이', '고등어구이'],
    '일식': ['초밥', '라멘', '돈까스', '회', '덮밥'],
    '중식': ['짜장면', '짬뽕', '탕수육', '양장피', '잡채밥'],
    '양식': ['피자', '스테이크', '샐러드', '햄버거', '파스타'],
  };

  String selectedCategory = '한식';
  String recommendedFood = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('음식 추천을 추천해드립니다!'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/recomend2.jfif'),
              fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height:ratio.height* 180,),
              DropdownButton<String>(
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                    recommendedFood = '';
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
              SizedBox(height:ratio.height* 250),
              if (recommendedFood.isNotEmpty)
                Text(
                  '추천 음식: $recommendedFood',
                  style: TextStyle(fontSize: 20),
                ),
              SizedBox(height:ratio.height* 20),
              ElevatedButton(
                onPressed: () {
                  recommendFood();
                },
                child: Text('음식 추천 받기'),
                style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void recommendFood() {
    setState(() {
      if (categoryToFoodMap.containsKey(selectedCategory)) {
        final List<String> selectedFoodList = categoryToFoodMap[selectedCategory]!;
        if (selectedFoodList.isNotEmpty) {
          final Random random = Random();
          final int randomIndex = random.nextInt(selectedFoodList.length);
          recommendedFood = selectedFoodList[randomIndex];
        } else {
          recommendedFood = '해당 카테고리의 음식 리스트가 비어있습니다.';
        }
      } else {
        recommendedFood = '선택된 카테고리가 없습니다.';
      }
    });
  }
}