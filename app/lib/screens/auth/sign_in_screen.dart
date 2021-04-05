import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfrontend/screens/auth/signin_textfield_widget.dart';

import '../../themes.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "/signIn";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _editingController;
  final _formKey = GlobalKey<FormState>();
  bool hasRegistered = true;
  bool isSignIn = false;

  @override
  void initState() {
    super.initState();
//    formState = FormState();
    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Themes.authBackGroundColor,
        body: Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SignInTextField("Email", validateEmail),
                if (isSignIn)SignInTextField("Password", validatePassword),

                if (!hasRegistered)
                  Container(
                    child: Column(
                      children: [
                        SignInTextField("Username", validateUsername),
                        SignInTextField("Password", validatePassword),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: RichText(
                            text: TextSpan(
                                text:
                                    "By tapping Save you are indicating that you agree to the ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: "Terms of Service",
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                                  TextSpan(text: "and the"),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.centerRight,
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    onPressed: submit,
                    child: Text("NEXT"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validateEmail(String val) {
    if (val.isEmpty) {
      return "Enter your email address to proceed";
    }
    if (!val.contains("@")) {
      return "The email address isn't correct";
    }
    return null;
  }

  String validatePassword(String val) {
    if (val.isEmpty) {
      return "Password not strong enough. Use at least 6 characters and a mix of letters nd numbers";
    }
    return null;
  }

  String validateUsername(String val) {
    if (val.isEmpty) return "You can't leave this empty";
    return null;
  }

  void submit() {
    _formKey.currentState.validate();
    setState(() {
      isSignIn = true;
    });
  }
}
