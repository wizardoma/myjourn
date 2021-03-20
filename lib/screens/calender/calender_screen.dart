
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  bool dayHasJournal = false;
  DateTime selectedDate = DateTime.now();
  CalendarController _calendarController;

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
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Material(
                elevation: 4,
                child: TableCalendar(
                  onDaySelected: (DateTime datetime,_,__) {
                    setState(() {
                      this.selectedDate = datetime;
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
          if (dayHasJournal)
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text("1 Story Found",
                      style:
                          TextStyle(color: Colors.grey.shade400, fontSize: 18)),
                ),
              ],
            ),
          if (!dayHasJournal)
            Container(

              margin: const EdgeInsets.symmetric(vertical: 40),
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                    spreadRadius: 1
                  )
                ]
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  var width = constraints.maxWidth;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: width*0.3,
                            child: Container(
                              width: 100,
                              height: 100,

                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: -8,
                              child: Image.asset("assets/logos/lock.png")),
                        ],
                      ),
                      Container(
                        width: width*0.6,
                        child: Text("Safeguard your memory on  ${DateFormat("dd MMMM y").format(selectedDate)}"
                          , style: Theme.of(context).textTheme.headline1.copyWith(
                            fontWeight: FontWeight.bold,

                          ),
                        textAlign: TextAlign.center,),
                      )

                    ],
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
