import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterfrontend/screens/auth/sign_in_screen.dart';
import 'package:flutterfrontend/widgets/signin_container.dart';

import '../../themes.dart';

class AuthenticationScreen extends StatelessWidget {
  static const routeName = "/auth";
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Themes.authBackGroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//          width: mediaQuery.width,
            alignment: Alignment.topCenter,
            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: mediaQuery.width,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      "Skip Login",
                      textAlign: TextAlign.right,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {},
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "MYJOURN",
                            style: Theme.of(context).textTheme.headline2.copyWith(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
//                      width: width * 0.3,
                              child: Container(
                                width: 170,
                                height: 170,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: -8,
                                right: 10,
                                child: Image.asset(
                                  "assets/logos/compose.png",
                                  fit: BoxFit.cover,
                                  height: 140,
                                  width: 140,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SignInContainer("assets/logos/google.png", Colors.white,
                            "Sign in with Google", null),
                        SignInContainer("assets/logos/facebook.png",
                            Colors.blue.shade900, "Sign in with Facebook", null),
                        SignInContainer("assets/logos/mail.png",
                            Colors.red.shade900, "Sign in with Email", signInWithEmail),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signInWithEmail(context){
    Navigator.pushNamed(context, SignInScreen.routeName);
  }
}
