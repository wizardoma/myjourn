import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterfrontend/widgets/signin_container.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.brown,
      body: SafeArea(

        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
//          width: mediaQuery.width,
          alignment: Alignment.topCenter,
          child: Center(
            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: mediaQuery.width,
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: Text("Skip Login",style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),),
                    onPressed: (){},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text("MYJOURN", style: Theme.of(context).textTheme.headline2.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                SizedBox(height: 20,),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
//                      width: width * 0.3,
                      child: Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          color:  Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: -8,
                        right: 10,
                        child: Image.asset("assets/logos/compose.png", fit: BoxFit.cover, height: 140, width: 140,)),
                  ],
                ),
                SizedBox(height: 20,),

                SignInContainer("assets/logos/google.png", Colors.white, "Sign in with Google"),
                SignInContainer("assets/logos/facebook.png", Colors.blue, "Sign in with Facebook"),
                SignInContainer("assets/logos/mail.png", Colors.red, "Sign in with Email"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
