import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String avatarUrl;
  final double width=60;
  final double height=90;

  const Avatar({Key? key, required this.avatarUrl}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Color(0xFFFFE6E6),
          borderRadius: BorderRadius.circular(50),
          image:
          DecorationImage(image: AssetImage('images/logo.png'), fit: BoxFit.cover)),
    );
  }
}