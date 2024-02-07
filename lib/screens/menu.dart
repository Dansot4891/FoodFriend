import 'package:flutter/material.dart';


class menu extends StatefulWidget {
  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(labelText: '검색해주세요.'),
          keyboardType: TextInputType.text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.forward),
          onPressed: (){
            Navigator.pop(context);
          }
        ),
      ),
    );
  }
}
