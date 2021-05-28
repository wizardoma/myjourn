import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal/journal_bloc.dart';
import 'package:flutterfrontend/bloc/journal/journal_events.dart';
import 'package:flutterfrontend/bloc/journal/journal_state.dart';
import 'package:flutterfrontend/screens/home/journal_list_items.dart';
import 'package:flutterfrontend/screens/journal/new_journal_screen.dart';
import 'package:shimmer/shimmer.dart';

class JournalList extends StatefulWidget {
  @override
  _JournalListState createState() => _JournalListState();
}

class _JournalListState extends State<JournalList> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<JournalBloc>(context).add(FetchJournalsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NewJournalScreen.routeName,
              arguments: {"isNew": true});
        },
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<JournalBloc, JournalState>(
          // ignore: missing_return
          builder: (BuildContext context, state) {
        if (state is FetchJournalsSuccess) {
          return state.journals.length == 0
              ? Center(
                  child: Text("No Journals"),
                )
              : JournalListItems(state.journals);
        }
        if (state is LoadingState || state is InitialJournalState) {
          return _shimmerChild();
        }
      }),
    );
  }

  Widget _shimmerChild() {
    var mQ = MediaQuery.of(context).size;
    return Container(
        height: mQ.height,
        width: mQ.width,
        child: Column(
          children: List.generate(
            3,
            (index) => Flexible(
              child: Container(
                height: 250,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: mQ.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer(
                        gradient: LinearGradient(
                          colors: [Colors.grey, Colors.grey.shade300],
                        ),
                        child: Container(
                          height: 60,
                          child: LayoutBuilder(
                            builder: (context, constraints) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: constraints.maxWidth * 0.5,
                                  height: 20,
                                  color: Colors.grey,
                                ),
                                Container(
                                  height: 20,
                                  width: constraints.maxWidth * 0.1,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: mQ.width,
                        height: 130,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer(
                              gradient: LinearGradient(
                                colors: [Colors.grey, Colors.grey.shade300],
                              ),
                              child: Container(
                                color: Colors.grey,
                                height: 15,
                                width: 40,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Shimmer(
                              gradient: LinearGradient(
                                colors: [Colors.grey, Colors.grey.shade300],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex:4,
                                    child: Container(
                                      color: Colors.grey,
                                      height: 100,
                                    ),
                                  ),
                                  SizedBox(width: 20,),

                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                        height: 80,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
