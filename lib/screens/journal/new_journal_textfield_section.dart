import 'package:flutter/material.dart';

class TextFieldSection extends StatelessWidget {
  final Function(String value) setHasContent;
  final TextEditingController bodyController;

  TextFieldSection(this.bodyController, this.setHasContent);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.only(top: 30),
      child: TextField(
        style: TextStyle(fontSize: 17),
        cursorColor: Theme.of(context).accentColor,
        autofocus: true,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        onChanged: (val) => setHasContent(val),
        controller: bodyController,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(10),
            hintStyle: TextStyle(color: Colors.grey),
            hintText: "Write here..."),
      ),
    );
  }
}
