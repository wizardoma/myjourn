import 'package:flutter/material.dart';

class SignInTextField extends StatefulWidget {
  final String labelText;
  final Function(String) validator;
  final TextEditingController textEditingController;

  const SignInTextField(this.labelText, this.validator, this.textEditingController);

  @override
  _SignInTextFieldState createState() => _SignInTextFieldState();
}

class _SignInTextFieldState extends State<SignInTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),

      child: TextFormField(
        keyboardType: widget.labelText == "Email"? TextInputType.emailAddress : TextInputType.text,
        controller: widget.textEditingController,
        decoration: InputDecoration(
            hintText: widget.labelText,
            labelText: widget.labelText
        ),
        validator:(s) => widget.validator(s),
      ),

    );
  }
}
