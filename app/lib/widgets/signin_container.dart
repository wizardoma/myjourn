import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInContainer extends StatelessWidget {
  final String asset, text;
  final Color backgroundColor;
  SignInContainer(this.asset, this.backgroundColor, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(5)
      ),
      child: SizedBox(
        child: ListTile(
          minVerticalPadding: 0,
          leading: Image.asset(asset, height: 30, width: 30,),
          title:   FittedBox(
            child: Text(text,overflow: TextOverflow.visible, style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: backgroundColor == Colors.white ? Colors.black.withOpacity(0.7): Colors.white
            ),),
          )),
      ),
    );
  }
}
