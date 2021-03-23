import 'package:flutter/material.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/screens/journal/view_journal_screen.dart';
import 'package:intl/intl.dart';

class JournalListItem extends StatelessWidget {
  final List<Journal> journals;

  JournalListItem(this.journals);

  @override
  Widget build(BuildContext context) {
    return Container(
//      height: 200,
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
                      DateFormat('d').format(journals[0].time),
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontSize: 25),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat('MMM').format(journals[0].time),
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: 25, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat('EEEE').format(journals[0].time),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Text(
                  DateFormat('y').format(journals[0].time),
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: journals.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => viewJournal(context, journals[index]),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('jm').format(journals[index].time),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Flexible(
                          child: Text(
                            journals[index]
                                .body
                                .toString()
                                .characters
                                .take(110)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  void viewJournal(BuildContext context, Journal journal) {
    Navigator.of(context).pushNamed(ViewJournalScreen.routeName,
        arguments: {"journal": journal});

  }
}
