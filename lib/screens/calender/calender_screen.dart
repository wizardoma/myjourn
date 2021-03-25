import 'package:flutter/material.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/providers/journal_provider.dart';
import 'package:flutterfrontend/screens/home/journal_list_items.dart';
import 'package:flutterfrontend/screens/journal/new_journal_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  List<Journal> dayJournals = [];
  Map<DateTime, List<Journal>> mappedJournals;
  List<Journal> allJournals = [];
  bool dayHasJournal = false;
  bool hasInitialized = false;
  String formattedDate = DateFormat("dd MMMM y").format(DateTime.now());
  Map<DateTime, List<dynamic>> events = {};
  DateTime selectedDate = DateTime.now();
  CalendarController _calendarController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!hasInitialized) {
      setState(() {
        allJournals =
            Provider.of<JournalProvider>(context, listen: false).journals;
        allJournals.forEach((e) {
          events.putIfAbsent(
              e.time,
              () => allJournals
                  .where((element) => areDatesEqual(e.time, element.time))
                  .toList());
        });
        hasInitialized = true;
        dayJournals = getDayJournals(DateTime.now());
        dayHasJournal = dayJournals.length > 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    super.dispose();
    _calendarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Material(
                  elevation: 4,
                  child: TableCalendar(
                    events: events,
                    onDaySelected: (DateTime datetime, _, __) {
                      setState(() {
                        var today = DateTime.now().toLocal();
                        this.selectedDate = DateTime(
                          datetime.year,
                          datetime.month,
                          datetime.day,
                          today.hour,
                          today.minute,
                          today.second,
                        );
                        formattedDate =
                            DateFormat("dd MMMM y").format(selectedDate);

                        var list = getDayJournals(selectedDate);
                        if (list.length == 0) {
                          dayHasJournal = false;
                          dayJournals = [];
                        } else {
                          dayHasJournal = true;
                          dayJournals = list;
                        }
                      });
                    },
                    builders: CalendarBuilders(),
                    calendarController: _calendarController,
                  ),
                ),
                Positioned(
                  bottom: -10,
                  right: 20,
                  child: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: createNewJournal,
                  ),
                ),
              ],
            ),
            if (dayHasJournal)
              Column(

                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                        "${dayJournals.length} ${dayJournals.length == 1 ? 'Story' : 'Stories'} Found",
                        style: TextStyle(
                            color: Colors.grey.shade400, fontSize: 18)),
                  ),
                  JournalListItems(dayJournals),
                ],
              ),
            if (!dayHasJournal)
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 40,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ]),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    var width = constraints.maxWidth;
                    return GestureDetector(
                      onTap: createNewJournal,
                      child: Container(
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: width * 0.3,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: !isAfterNow()
                                          ? Colors.green
                                          : Colors.lightGreen,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: -8,
                                    child: Image.asset(!isAfterNow()
                                        ? "assets/logos/lock.png"
                                        : "assets/logos/compose.png")),
                              ],
                            ),
                            Container(
                              width: width * 0.6,
                              child: Text(
                                !isAfterNow()
                                    ? "Safeguard your memory on $formattedDate"
                                    : "Plan your $formattedDate",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  bool isAfterNow() {
    return selectedDate.isAfter(DateTime.now());
  }

  bool areDatesEqual(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  void createNewJournal() {
    Navigator.pushNamed(context, NewJournalScreen.routeName, arguments: {
      "isNew": true,
      "date": selectedDate,
    });
  }

  List<Journal> getDayJournals(DateTime dateTime) {
    return allJournals.where((element) {
      return areDatesEqual(dateTime, element.time);
    }).toList();
  }
}
