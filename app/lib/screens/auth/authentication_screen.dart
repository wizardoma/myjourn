import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/auth/auth_bloc.dart';
import 'package:flutterfrontend/bloc/auth/authentication_event.dart';
import 'package:flutterfrontend/bloc/auth/authentication_state.dart';
import 'package:flutterfrontend/screens/auth/sign_in_screen.dart';
import 'package:flutterfrontend/screens/home/home_screen.dart';
import 'package:flutterfrontend/ui_helpers.dart';
import 'package:flutterfrontend/widgets/guest_sign_in_prompt.dart';
import 'package:flutterfrontend/widgets/signin_container.dart';
import '../../bloc/auth/auth_bloc.dart';

import '../../themes.dart';

class AuthenticationScreen extends StatelessWidget {
  static const routeName = "/auth";

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state){
        if (state is IsAuthenticated){
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
        }
      },
      child: Scaffold(
        backgroundColor: Themes.authBackGroundColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: mediaQuery.height,
              child: Stack(

                children: [
                  Container(
                    alignment: Alignment.topRight,
                    width: mediaQuery.width,
                    child: TextButton(
                      child: Text(
                        "Skip Login",
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () {
                        showDialog(context: context, builder: (context) => GuestSignInPrompt(signInWithGuest));
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: LayoutBuilder(
                      builder: (c,cn) =>  Container(
//                        decoration: BoxDecoration(color: Colors.black87),
                        alignment: Alignment.center,
                        height: cn.maxHeight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(defaultSpacing * 0.5),
                              child: Text(
                                "MYJOURN",
                                style: Theme.of(context).textTheme.headline2.copyWith(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                            kVerticalSpaceMedium,
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
                            kVerticalSpaceMedium,
                            SignInContainer("assets/logos/google.png", Colors.white,
                                "Sign in with Google", null),
                            kVerticalSpaceRegular,
                            SignInContainer("assets/logos/facebook.png",
                                Colors.blue.shade900, "Sign in with Facebook", null),
                            kVerticalSpaceRegular,

                            SignInContainer("assets/logos/mail.png",
                                Colors.red.shade900, "Sign in with Email", signInWithEmail),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signInWithEmail(context){
    Navigator.pushNamed(context, SignInScreen.routeName);
  }

  void signInWithGuest(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context,listen: false).add(GuestLoginEvent());
  }
}
