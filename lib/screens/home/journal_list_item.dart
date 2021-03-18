import 'package:flutter/material.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/screens/journal/view_journal_screen.dart';
import 'package:intl/intl.dart';

class JournalListItem extends StatelessWidget {
  final Journal journal;

  JournalListItem(this.journal);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      DateFormat('d').format(journal.time),
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontSize: 25),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat('MMM').format(journal.time),
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat('EEEE').format(journal.time),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Text(
                  DateFormat('y').format(journal.time),
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('jm').format(journal.time),
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: 3,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () => viewJournal(context),
                    child: Text(
                      journal.body.toString().characters.take(110).toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void viewJournal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(ViewJournalScreen.routeName, arguments: journal);
  }
}
