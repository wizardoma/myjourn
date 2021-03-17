import 'package:flutter/material.dart';

class JournalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Text("No Journals Found"),
      ),
    );
  }
}
