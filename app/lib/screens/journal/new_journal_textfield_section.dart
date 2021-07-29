import 'package:flutter/material.dart';
import 'package:flutterfrontend/ui_helpers.dart';

class TextFieldSection extends StatelessWidget {
  final Function(String value) setHasContent;
  final TextEditingController bodyController;

  TextFieldSection(this.bodyController, this.setHasContent);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.only(top: defaultSpacing * 2),
      child: TextField(
        style: TextStyle(
          fontSize: 17,
          color: Theme.of(context).textTheme.headline1.color
        ),
        cursorColor: Theme.of(context).accentColor,
        autofocus: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (val) => setHasContent(val),
        controller: bodyController,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(defaultSpacing * 0.5),
            hintStyle: TextStyle(color: Colors.grey),
            hintText: "Write here..."),
      ),
    );
  }
}
