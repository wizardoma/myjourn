import 'package:flutter/material.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:intl/intl.dart';

class NewJournalScreen extends StatefulWidget {
  static const routeName = "/newJournal";

  @override
  _NewJournalScreenState createState() => _NewJournalScreenState();
}

class _NewJournalScreenState extends State<NewJournalScreen> {
  TextEditingController bodyController;
  bool hasContent;

  @override
  void dispose() {
    super.dispose();
    bodyController.dispose();
  }

  @override
  void initState() {
    super.initState();
    bodyController = TextEditingController();
  }

  Journal generateJournal(Map<String, Object> pageArgs) {
    if (pageArgs["isNew"]) {
      return Journal(DateTime.now().toString(), "", DateTime.now());
    } else {
      print((pageArgs["journal"] as Journal).time);
      return pageArgs["journal"] as Journal;
    }
  }

  @override
  Widget build(BuildContext context) {
    var pageArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    var isNewJournal = pageArgs["isNew"];
    var journal = generateJournal(pageArgs);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Write",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.linked_camera,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
          if (!isNewJournal)
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onPressed: () {})
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 70,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  DateFormat('d').format(journal.time),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      .copyWith(fontSize: 50),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        DateFormat('EEEE').format(journal.time),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            .copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        DateFormat("MMMM").format(journal.time),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1
                                            .copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              DateFormat('jm').format(journal.time),
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: TextField(
                          style: TextStyle(fontSize: 17),
                          cursorColor: Theme.of(context).accentColor,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "Write here..."),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade200,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 0))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {

                      },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
