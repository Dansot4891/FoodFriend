import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback func;
  final double horizonMargin;
  final String text;
  const CustomButton({
    this.horizonMargin = 0,
    required this.text,
    required this.func,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: horizonMargin),
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.white),
        )),
      ),
    );
  }
}
