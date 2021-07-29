import 'package:flutter/material.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/ui_helpers.dart';
import 'package:intl/intl.dart';

class DateSection extends StatelessWidget {
  final Function(BuildContext context) openDatePicker;
  final Function(BuildContext context) openTimePicker;
  final Journal journal;

  DateSection(this.openDatePicker, this.openTimePicker, this.journal);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(vertical: defaultSpacing * 0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => openDatePicker(context),
            child: Container(
              child: Row(
                children: [
                  Text(
                    DateFormat('d').format(journal.time),
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(fontSize: 50),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEEE')
                              .format(journal.time),
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(
                              fontSize: 20,
                              fontWeight:
                              FontWeight.w600),
                        ),
                        Text(
                          DateFormat("MMMM")
                              .format(journal.time),
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(
                              fontSize: 20,
                              fontWeight:
                              FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.edit,
                      size: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => openTimePicker(context),
            child: Container(
              child: Row(
                children: [
                  Container(
                    child: Text(
                      DateFormat('jm').format(journal.time),
                      style: Theme.of(context)
                          .textTheme
                          .headline3,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Container(
                    child: Icon(
                      Icons.edit,
                      size: 15,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}
