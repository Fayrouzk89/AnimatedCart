import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
  final String text;
   Color? color=Colors.black;
  final double fontSize= 12;
  final FontWeight fontWeight= FontWeight.w700;
  final TextOverflow overflow=TextOverflow.visible;

   PrimaryText({Key? key, required this.text,this.color}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'Quicksand',
        fontWeight: fontWeight,
      ),
    );
  }
}