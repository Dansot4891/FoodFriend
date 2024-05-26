import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_friend/config/custom_button.dart';
import 'package:food_friend/config/custom_dialog.dart';
import 'package:food_friend/config/validator.dart';
import 'package:food_friend/main.dart';
import 'package:food_friend/model/union_model.dart';
import 'package:food_friend/provider/union_provider.dart';
import 'package:food_friend/widget/custom_textfield.dart';

class UnionInfoScreen extends ConsumerStatefulWidget {
  UnionModel data;
  UnionInfoScreen({
    required this.data,
    super.key});

  @override
  UnionInfoScreenState createState() => UnionInfoScreenState();
}

class UnionInfoScreenState extends ConsumerState<UnionInfoScreen> {
  // @override
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    final valueList = ['한식', '일식', '중식', '양식', '배달'];
    String type = widget.data.type;
    TextEditingController titleController = TextEditingController(text: widget.data.title);
    TextEditingController maxController = TextEditingController(text: widget.data.max);
    TextEditingController numController = TextEditingController(text: widget.data.num);
    TextEditingController peopleController = TextEditingController(text: widget.data.users.join(', '));
    TextEditingController placeController = TextEditingController(text: widget.data.place);
    TextEditingController timeController = TextEditingController(text: widget.data.time);
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('제목', style: TextStyle(fontSize: 20)),
                    SizedBox(height: ratio.height * 5,),
                    CustomTextField(controller: titleController, hintText: '제목을 입력해주세요.', validator: titleValidator,),
                    SizedBox(
                      height: ratio.height * 20,
                    ),
                    Text('최대 인원', style: TextStyle(fontSize: 20)),
                    SizedBox(height: ratio.height * 5,),
                    CustomTextField(controller: maxController, hintText: '최대 인원을 입력해주세요.', validator: maxValidator, inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],),
                    SizedBox(
                      height: ratio.height * 20,
                    ),
                    Text('현재 인원', style: TextStyle(fontSize: 20)),
                    SizedBox(height: ratio.height * 5,),
                    CustomTextField(enabled: false, controller: numController, hintText: '현재 인원을 입력해주세요.', ),
                    SizedBox(
                      height: ratio.height * 20,
                    ),
                    Text('현재 참가 인원', style: TextStyle(fontSize: 20)),
                    SizedBox(height: ratio.height * 5,),
                    CustomTextField(enabled: false, controller: peopleController, hintText: '현재 참가 인원이 없습니다.',),
                    SizedBox(
                      height: ratio.height * 20,
                    ),
                    Text('시간대', style: TextStyle(fontSize: 20)),
                    SizedBox(height: ratio.height * 5,),
                    CustomTextField(controller: timeController, hintText: '시간을 입력해주세요.', validator: timeValidator,),
                    SizedBox(
                      height: ratio.height * 20,
                    ),
                    Text('장소', style: TextStyle(fontSize: 20)),
                    SizedBox(height: ratio.height * 5,),
                    CustomTextField(controller: placeController, hintText: '만날 장소를 입력해주세요.', validator: placeValidator,),
                    SizedBox(
                      height: ratio.height * 25,
                    ),
                    Center(
                      child: Text(
                        '카테고리',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: ratio.height * 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      DropdownButton(
                        value: type,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: valueList.map((String val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        onChanged: (String? val) {
                          setState(() { 
                            type = val!;
                            widget.data = widget.data.copyWith(max: maxController.text, num: numController.text, place: placeController.text, time: timeController.text, title: titleController.text, type: val, userid: widget.data.userid, dep: widget.data.dep);
                          });
                          print(widget.data);
                        },
                      ),

                    ],),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                CustomButton(text: '수정하기', func: () async {
                  final newData = UnionModel(max: maxController.text, num: numController.text, place: placeController.text, time: timeController.text, title: titleController.text, type: type, userid: widget.data.userid, dep: widget.data.dep);
                  if (_formkey.currentState!.validate()) {
                    if(int.parse(widget.data.num) > int.parse(maxController.text)){
                      CustomDialog(context: context, title: '최대 인원과 현재 인원을 확인해주세요.', buttonText: '확인', buttonCount: 1, func: (){
                        Navigator.pop(context);
                      });
                      return;
                    }
                    ref.read(unionProvider.notifier).changeUnion(union : newData, context: context, title: widget.data.title);
                  }
                }, horizonMargin: 20,),
                SizedBox(height: ratio.height * 20,),
              ],
            ),
          )
        ],
      )
    );
  }
}
