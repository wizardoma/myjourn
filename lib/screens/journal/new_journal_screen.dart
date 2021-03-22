import 'package:flutter/material.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/providers/journal_provider.dart';
import 'package:flutterfrontend/screens/home/home_screen.dart';
import 'package:flutterfrontend/screens/journal/view_journal_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewJournalScreen extends StatefulWidget {
  static const routeName = "/newJournal";

  @override
  _NewJournalScreenState createState() => _NewJournalScreenState();
}

class _NewJournalScreenState extends State<NewJournalScreen> {
  TextEditingController bodyController;
  bool hasContent = false;
  Function(int id, BuildContext context) deleteJournal;
  Journal journal;
  bool isNewJournal;
  bool hasBuilt = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!hasBuilt) {
      setState(() {
        var pageArgs =
        ModalRoute
            .of(context)
            .settings
            .arguments as Map<String, Object>;
        isNewJournal = pageArgs["isNew"];
        journal = generateJournal(pageArgs);
        hasBuilt = true;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: checkForLeadingAppBarContent(),
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
                onPressed: () {
                  deleteJournal(journal.id, context);
//                  Navigator.pop(context,true);
                })
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
                                  style: Theme
                                      .of(context)
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
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline2
                                            .copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        DateFormat("MMMM").format(journal.time),
                                        style: Theme
                                            .of(context)
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
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headline3,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: TextField(
                          style: TextStyle(fontSize: 17),
                          cursorColor: Theme
                              .of(context)
                              .accentColor,
                          autofocus: true,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (val) {
                            if (val == null || val.isEmpty) {
                              setState(() {
                                hasContent = false;
//                                bodyController.text = val;
                              });
                            } else {
                              setState(() {
//                                bodyController.text = val;
                                hasContent = true;
                              });
                            }
                          },
                          controller: bodyController,
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
                      onPressed: () => discardChanges(context),
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

  Widget checkForLeadingAppBarContent() {
    return hasContent
        ? IconButton(
      icon: Icon(
        Icons.check_circle,
        size: 35,
        color: Colors.green,
      ),
      onPressed: saveJournal,
    )
        : IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.grey,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  Journal generateJournal(Map<String, Object> pageArgs) {
    if (pageArgs["isNew"]) {
      var date = pageArgs["date"] == null ? DateTime.now() : pageArgs["date"];
      return Journal(DateTime
          .now()
          .millisecondsSinceEpoch, "", date);
    } else {
      deleteJournal = pageArgs["delete"] as Function;
      var journal = pageArgs["journal"] as Journal;
      bodyController.text = journal.body;
      hasContent = true;
      return journal;
    }
  }

  void discardChanges(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Do you want to discard the changes?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text("CANCEL")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text("DISCARD")),
            ],
          );
        }).then((value) {
      if (value) Navigator.pop(context);
    });
  }

  Future<void> saveJournal() async {
    int id = journal.id;
    String body = bodyController.text;
    DateTime time = isNewJournal ? DateTime.now().toLocal() : journal.time;

    Journal savedJournal = Journal(id, body, time);

    var journalProvider = Provider.of<JournalProvider>(context, listen: false);
    if (isNewJournal) {
      journalProvider.addJournal(savedJournal).then((value) {
        if (value)
          viewJournalAfterSave(context, savedJournal);
        else
          showErrorMessage(context);
      });
    } else {
      journalProvider.editJournal(savedJournal).then((value) {
        if (value)
          viewJournalAfterSave(context, savedJournal);
        else
          showErrorMessage(context);
      });
    }
  }

  void viewJournalAfterSave(BuildContext context, Journal savedJournal) {
    Navigator.pushReplacementNamed(context, ViewJournalScreen.routeName,
        arguments: { "journal": savedJournal,
          "screen": HomeScreen.routeName});
  }

  void showErrorMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("There was an error saving this journal"))
    );
  }
}