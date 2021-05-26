import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget leading;
  final Widget title;
  final List<Widget> actions;


  const CustomAppBar({Key key, this.leading, this.title, this.actions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      title: title,
      leading: leading,

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
