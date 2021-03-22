import 'package:flutter/material.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/screens/home/journal_list_item.dart';
import 'package:flutterfrontend/util/journal_util.dart';

class JournalListItems extends StatelessWidget with JournalUtils {

  final List<Journal> _journals ;

  JournalListItems(this._journals);

  @override
  Widget build(BuildContext context) {
    var mappedJournals = listToMapView(_journals);
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 2,
        );
      },
      itemCount: mappedJournals.length,
      itemBuilder: (context, index) {

        return JournalListItem(mappedJournals.values.elementAt(index));
      },
    );
  }

}