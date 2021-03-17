import 'package:flutter/material.dart';
import 'package:flutterfrontend/providers/journal_provider.dart';
import 'package:provider/provider.dart';

class JournalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final journals = Provider.of<JournalProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: journals.size == 0
          ? Center(
              child: Text("No Journals"),
            )
          : ListView.builder(
              itemCount: journals.size,
              itemBuilder: (context, index) => Container(
                    height: 200,
                    padding: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
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
                                    "19",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(fontSize: 25),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "FEB",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .copyWith(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "FRIDAY",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Text(
                                "2021",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
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
                                "08:24 pm",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                journals.journals[index].body,
                                style: Theme.of(context).textTheme.headline1.copyWith(
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
    );
  }
}
