import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInContainer extends StatelessWidget {
  final String asset, text;
  final Color backgroundColor;
  final Function(BuildContext context) action;
  SignInContainer(this.asset, this.backgroundColor, this.text, this.action);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(5)
      ),
      child: SizedBox(
        child: ListTile(
          onTap: () => action(context),
          minVerticalPadding: 0,
          leading: Image.asset(asset, height: 30, width: 30,),
          title:   Text(text,overflow: TextOverflow.visible, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: backgroundColor == Colors.white ? Colors.black.withOpacity(0.7): Colors.white
          ),)),
      ),
    );
  }
}
