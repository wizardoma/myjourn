import 'package:flutter/material.dart';

class BottomSection extends StatefulWidget {
  final Function(BuildContext context) discardChanges;
  final TextEditingController bodyController;

  BottomSection(this.discardChanges, this.bodyController);

  @override
  _BottomSectionState createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 0))
        ],
      ),
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => widget.discardChanges(context),
              icon: Icon(
                Icons.clear,
                color: Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.mic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Container(
          height: 60,
          color: Theme.of(context).cardColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Listening",
                style: Theme.of(context).textTheme.headline1,
              ),
              Icon(
                Icons.mic,
              )
            ],
          ),
        )
      ]),
    );
  }
}
