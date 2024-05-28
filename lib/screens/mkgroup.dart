import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/config/custom_button.dart';
import 'package:food_friend/config/custom_dialog.dart';
import 'package:food_friend/config/validator.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/model/union_model.dart';
import 'package:food_friend/provider/union_provider.dart';
import 'package:food_friend/provider/user_provider.dart';
import 'package:food_friend/screens/home.dart';
import 'package:food_friend/widget/custom_textfield.dart';

class MakeGroupScreen extends ConsumerStatefulWidget {
  final String? title;
  final String? type;
  MakeGroupScreen({
    Key? key,
    this.title,
    this.type,
  }) : super(key: key);
  @override
  MakeGroupScreenState createState() => MakeGroupScreenState();
}

class MakeGroupScreenState extends ConsumerState<MakeGroupScreen> {

  GlobalKey<FormState> gkey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _maxController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  final valueList = ['한식', '일식', '중식', '양식', '배달'];

  String food = '한식';

  final inputFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly
  ];

  @override
  void initState() {
    super.initState();
    if(widget.title != null){
      _titleController = TextEditingController(text: widget.title);
    }
    if(widget.type != null){
      food = widget.type!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(UserProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '맘마 만들기',
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
      body: Form(
        key: gkey,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Image.asset('assets/lunch.png'),
                    CustomTextField(
                      controller: _titleController,
                      hintText: '제목을 입력해주세요.',
                      validator: titleValidator,
                    ),
                    SizedBox(
                      height: ratio.height * 15,
                    ),
                    CustomTextField(
                      controller: _maxController,
                      hintText: '최대 인원을 입력해주세요.',
                      validator: maxValidator,
                      inputFormatter: inputFormatter,
                    ),
                    SizedBox(
                      height: ratio.height * 15,
                    ),
                    CustomTextField(
                      controller: _timeController,
                      hintText: '시간대를 입력해주세요.',
                      validator: timeValidator,
                    ),
                    SizedBox(
                      height: ratio.height * 15,
                    ),
                    CustomTextField(
                      controller: _placeController,
                      hintText: '만날 장소를 입력해주세요.',
                      validator: placeValidator,
                    ),
                    SizedBox(
                      height: ratio.height * 50,
                    ),
                    Text(
                      '선정하신 음식의 카테고리를 선택해주세요.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: ratio.height * 15,
                    ),
                    DropdownButton(
                        value: food,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: valueList.map((String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        onChanged: (String? val) {
                          setState(() {
                            food = val!;
                          });
                        }),
                    
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Spacer(),
                    CustomButton(text: '생성', func: () async {
                      if (gkey.currentState!.validate()) {
                        final union = UnionModel(type: food,title: _titleController.text,max: _maxController.text,num: '1', time: _timeController.text, place: _placeController.text,dep: user.dep, userid: user.id, users: [user.id]);
                        await ref.read(unionProvider.notifier).makeGroup(union : union);
                        //await makeGroup(user);
                        CustomDialog(context: context, title: '생성이 완료되었습니다', buttonText: '확인', buttonCount: 1, func: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_){
                            return HomeScreen();
                          }));
                        });
                      }
                    }),
                    SizedBox(
                      height: ratio.height * 40,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
