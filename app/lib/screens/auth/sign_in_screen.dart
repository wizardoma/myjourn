import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/auth/auth_bloc.dart';
import 'package:flutterfrontend/bloc/auth/authentication_event.dart';
import 'package:flutterfrontend/bloc/auth/authentication_state.dart';
import 'package:flutterfrontend/screens/auth/signin_textfield_widget.dart';

import '../../themes.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "/signIn";

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailEditingController;
  TextEditingController _passwordEditingController;
  TextEditingController _usernameEditingController;
  final _formKey = GlobalKey<FormState>();
  bool willRegister = false;
  bool isSignIn = false;

  @override
  void initState() {
    super.initState();
//    formState = FormState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _usernameEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _usernameEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Themes.authBackGroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is FetchingDataState){
                  showLoadingState(context);
                }
                if (state is EmailIsAvailableState) {
                  setState(() {
                    isSignIn = true;
                    willRegister = false;
                  });
                }

                if (state is EmailNotAvailableState) {
                  print("from ui: email is not available");
                  setState(() {
                    isSignIn = false;
                    willRegister = true;
                  });
                }
              },
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SignInTextField(
                        "Email", validateEmail, _emailEditingController),
                    if (isSignIn)
                      SignInTextField("Password", validatePassword,
                          _passwordEditingController),
                    if (willRegister)
                      Container(
                        child: Column(
                          children: [
                            SignInTextField("Username", validateUsername,
                                _usernameEditingController),
                            SignInTextField("Password", validatePassword,
                                _passwordEditingController),
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
    if (_formKey.currentState.validate()) {
      print("it is validated");
      context
          .read<AuthenticationBloc>()
          .add(VerifyUniqueEmailEvent(_emailEditingController.text));
    }
    else {
      print("it is not validated");
    }
  }

  void showLoadingState(BuildContext uiContext) {
    showDialog(context: uiContext, builder: (context) {
      return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is EmailNotAvailableState || state is EmailIsAvailableState) Navigator.pop(context);
        },

        child: AlertDialog(
          content: ListTile(
            title: Text("Checking for existing account"),
            leading: CircularProgressIndicator(),
          ),
        ),
      );
    });

  }
}
