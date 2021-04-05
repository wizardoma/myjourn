import 'package:flutter/material.dart';

class SignInTextField extends StatelessWidget {
  final String labelText;
  final Function(String) validator;

  const SignInTextField(this.labelText, this.validator);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: labelText,
            labelText: labelText
        ),
        validator:(s) => validator(s),
      ),

    );
  }
}
