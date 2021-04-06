import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/auth/auth_bloc.dart';
import 'package:flutterfrontend/bloc/auth/authentication_event.dart';
import 'package:flutterfrontend/bloc/auth/authentication_state.dart';
import 'package:flutterfrontend/screens/auth/signin_textfield_widget.dart';
import 'package:flutterfrontend/screens/home/home_screen.dart';
import 'package:flutterfrontend/services/auth/login_request.dart';
import 'package:flutterfrontend/services/auth/signup_request.dart';
import 'package:flutterfrontend/services/auth/verify_email_request.dart';

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
  Map<String, dynamic> serverErrors = {};
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
  Widget build(BuildContext mainContext) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Themes.authBackGroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is FetchingDataState) {
                  if (isVerifyEmail()) {
                    showLoadingState(
                        context, "Checking for Existing accounts", "verify");
                  } else if (isSignIn) {
                    showLoadingState(context, "Logging in", "login");
                  } else if (willRegister) {
                    showLoadingState(context, "Signing Up", "signUp");
                  }
                }

                if (isVerifyEmail()) {
                  if (state is EmailIsAvailableState) {
                    setState(() {
                      isSignIn = false;
                      willRegister = true;
                    });
                  }

                  if (state is EmailNotAvailableState) {
                    print("from ui: email is not available");
                    setState(() {
                      isSignIn = true;
                      willRegister = false;
                    });
                  }
                }

                if (state is NotAuthenticated) {
                  print("Not authenticated");
                  print(state.errors.toString());
                  setState(() {
                    serverErrors = state.errors;
                  });
                  showErrorMessage();
                  _formKey.currentState.validate();
                  serverErrors = {};
                }

                if (state is IsAuthenticated) {
                  print("successfully logged in");
                  Navigator.popUntil(
                      mainContext, ModalRoute.withName(HomeScreen.routeName));
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
                                    style: Theme.of(mainContext)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontSize: 16),
                                    children: [
                                      TextSpan(
                                        text: "Terms of Service",
                                        style: TextStyle(
                                            color: Theme.of(mainContext)
                                                .accentColor),
                                      ),
                                      TextSpan(text: "and the"),
                                      TextSpan(
                                        text: "Privacy Policy",
                                        style: TextStyle(
                                            color: Theme.of(mainContext)
                                                .accentColor),
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
                        color: Theme.of(mainContext).accentColor,
                        onPressed: submit,
                        child: Text(isVerifyEmail()
                            ? "NEXT"
                            : isSignIn
                                ? "LOGIN"
                                : willRegister
                                    ? "SIGN UP"
                                    : "NEXT"),
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
    if (serverErrors["field.email"]!=null){return serverErrors["field.email"].toString();}
    return null;
  }

  String validatePassword(String val) {
    if (val.isEmpty) {
      return "Password not strong enough. Use at least 6 characters and a mix of letters nd numbers";
    }
    if (serverErrors["field.password"]!=null){return serverErrors["field.password"].toString();}

    return null;
  }

  String validateUsername(String val) {
    if (val.isEmpty) return "You can't leave this empty";
    if (serverErrors["field.username"]!=null){return serverErrors["field.username"].toString();}

    return null;
  }

  void submit() {
    if (_formKey.currentState.validate()) {
      print("it is validated");
      if (isSignIn) {
        login(LoginRequest(
            _emailEditingController.text, _passwordEditingController.text));
      } else if (willRegister) {
        signUp(SignUpRequest(_emailEditingController.text, _usernameEditingController.text,
            _passwordEditingController.text,  SignUpType.email));
      } else if (isVerifyEmail()) {
        verifyEmail(VerifyEmailRequest(_emailEditingController.text));
      }
    } else {
      print("it is not validated");
    }
  }

  void login(LoginRequest request) {
    serverErrors = {};
    context.read<AuthenticationBloc>().add(LoginEvent(request));
  }

  void signUp(SignUpRequest request) {
    serverErrors = {};
    context.read<AuthenticationBloc>().add(SignUpEvent(request));
  }

  void showLoadingState(BuildContext uiContext, String message, String event) {
    showDialog(
        context: uiContext,
        builder: (context) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if ((state is EmailNotAvailableState ||
                      state is EmailIsAvailableState) &&
                  event == "verify") {
                Navigator.pop(context);
              } else if ((event == "login" || event == "signUp") &&
                  (state is NotAuthenticated)) {
                Navigator.pop(context);
              }
            },
            child: AlertDialog(
              content: ListTile(
                title: Text(message),
                leading: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }

  void verifyEmail(VerifyEmailRequest verifyEmailRequest) {
    serverErrors = {};
    context.read<AuthenticationBloc>().add(VerifyUniqueEmailEvent(
        VerifyEmailRequest(_emailEditingController.text)));
  }

  bool isVerifyEmail() {
    return !isSignIn && !willRegister;
  }

  void showErrorMessage() {

    if (serverErrors == null || serverErrors.length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please make sure you field the form correctly and try again")));
      return;
    } else {
      if (serverErrors["authentication.error"] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(serverErrors["authentication.error"].toString())));
        return;
      }
//
//      if (serverErrors.keys.firstWhere((element) => element.contains("field"))!=null){
//        if (serverErrors[])
//      }
    }
  }
}
