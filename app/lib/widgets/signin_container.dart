import 'package:flutter/material.dart';

class SignInContainer extends StatelessWidget {
  final String asset, text;
  final Color backgroundColor;
  SignInContainer(this.asset, this.backgroundColor, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
//      height: 40,
//      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        minVerticalPadding: 0,
        leading: Image.asset(asset, height: 30, width: 30,),
        title:   Text(text, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: backgroundColor == Colors.white ? Colors.grey: Colors.white
        ),)),
    );
  }
}
