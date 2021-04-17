import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../themes.dart';

class GuestSignInPrompt extends StatelessWidget {
  final Function(BuildContext context) signIn;

  const GuestSignInPrompt(this.signIn);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Themes.authBackGroundColor,
      content: Container(
          height: 200,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    child: Image.asset(
                      "assets/logos/compose.png",
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    child: Center(
                      child: Text(
                        " Skip login is only for guest users to try out MyJourn. "
                        "If you are an existing user, please login to ensure your entries are saved.",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("DISMISS")),
        TextButton(
          onPressed: () => signIn(context),
          child: Text("TRY OUT MYJOURN"),
        ),
      ],
    );
  }
}
