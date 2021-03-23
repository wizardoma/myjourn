import 'package:flutter/material.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/providers/journal_provider.dart';
import 'package:flutterfrontend/screens/journal/image_carousel.dart';
import 'package:flutterfrontend/screens/journal/new_journal_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ViewJournalScreen extends StatelessWidget {
  static const routeName = "/viewJournal";

  void deleteJournal(int id, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(15),
            content: Text("Do you want to delete this note?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("CANCEL")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("DELETE"))
            ],
          );
        }).then((value) {
      if (value) {
        return Provider.of<JournalProvider>(context, listen: false)
            .deleteJournal(id);
      }
    }).then((result) {
      if (!result) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("An error occurred deleting this journal")));
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pageRoute =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final journal = pageRoute["journal"] as Journal;
    print("Incoming journal ${journal.toString()}");

    return Scaffold(
      appBar: AppBar(
        title: Text("MyJourn"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            String screen = pageRoute["screen"];
            screen != null
                ? Navigator.popAndPushNamed(context, screen)
                : Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(NewJournalScreen.routeName,
                    arguments: {
                      "isNew": false,
                      "journal": journal,
                      "delete": deleteJournal
                    }).then((value) {
                  if (Provider.of<JournalProvider>(context, listen: false)
                          .findById(journal.id) ==
                      null) {
                    Navigator.pop(context);
                  }
                });
              }),
          IconButton(icon: Icon(Icons.print), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteJournal(journal.id, context)),
        ],
      ),
      body: Container(
        constraints: BoxConstraints(
            minHeight: 260,
            maxHeight: MediaQuery.of(context).size.height * 0.8),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 0))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (journal.images!=null) JournalImageCarousel(journal.images),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Flexible(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              journal.body,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
