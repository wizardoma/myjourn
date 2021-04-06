import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInTextField extends StatefulWidget {
  final String labelText;
  final Function(String) validator;
  final TextEditingController textEditingController;

  const SignInTextField(
      this.labelText, this.validator, this.textEditingController);

  @override
  _SignInTextFieldState createState() => _SignInTextFieldState();
}

class _SignInTextFieldState extends State<SignInTextField> {
  FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        style: Theme.of(context).textTheme.headline4.copyWith(fontSize: 15),
        keyboardType: widget.labelText == "Email"
            ? TextInputType.emailAddress
            : TextInputType.text,
        controller: widget.textEditingController,

        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade600)
          ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade600)
            ),border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade600)
        ),
//            hintText: widget.labelText,
            labelText: widget.labelText,
            labelStyle:
                Theme.of(context).textTheme.headline2.copyWith(fontSize: 15)),
        validator: (s) => widget.validator(s),
      ),
    );
  }
}
