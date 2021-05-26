import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfrontend/bloc/journal/journal_bloc.dart';
import 'package:flutterfrontend/bloc/journal/journal_events.dart';
import 'package:flutterfrontend/bloc/journal/journal_state.dart';
import 'package:flutterfrontend/models/journal.dart';
import 'package:flutterfrontend/screens/home/home_screen.dart';
import 'package:flutterfrontend/screens/journal/image_carousel.dart';
import 'package:flutterfrontend/screens/journal/new_journal_date_section.dart';
import 'package:flutterfrontend/screens/journal/view_journal_screen.dart';
import 'package:image_picker/image_picker.dart';

import 'new_journal_bottom_section.dart';
import 'new_journal_textfield_section.dart';

class NewJournalScreen extends StatefulWidget {
  static const routeName = "/newJournal";

  @override
  _NewJournalScreenState createState() => _NewJournalScreenState();
}

class _NewJournalScreenState extends State<NewJournalScreen> {
  TextEditingController bodyController;
  bool hasContent = false;
  Function(int id, BuildContext context) deleteJournal;
  List<Uint8List> images;
  Journal journal;
  bool isNewJournal;
  bool hasBuilt = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!hasBuilt) {
      setState(() {
        var pageArgs =
            ModalRoute.of(context).settings.arguments as Map<String, Object>;
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
    var mediaQuery = MediaQuery.of(context);
    var bottomInset = mediaQuery.viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: checkForLeadingAppBarContent(),
        title: Text(
          "Write",
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.linked_camera,
              color: Colors.grey,
            ),
            onPressed: selectImage,
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
      body: BlocListener<JournalBloc, JournalState>(
        listener: (context, state) {
          if (state is AddJournalFailure || state is EditFailure) {
            showErrorMessage(context);
          }
          if (state is AddJournalSuccess) {
            viewJournalAfterSave(context, state.journal);
          }
          if (state is EditSuccess) {
            viewJournalAfterSave(context, state.journal);
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: bottomInset <= 10 ? 0 : bottomInset + 50,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          if (images != null) JournalImageCarousel(images),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DateSection(
                                    openDatePicker, openTimePicker, journal),
                                TextFieldSection(bodyController, setHasContent),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: mediaQuery.viewInsets.bottom,
                    left: 0,
                    right: 0,
                    child: Container(
//                  alignment: Alignment.bottomCenter,
                      child: BottomSection(discardChanges, bodyController),
                    ),
                  )
                ],
              ),
            ),
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
              color: Theme.of(context).accentColor.withOpacity(0.8),
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
      return Journal(DateTime.now().millisecondsSinceEpoch, "", date);
    } else {
      deleteJournal = pageArgs["delete"] as Function;
      var journal = pageArgs["journal"] as Journal;
      bodyController.text = journal.body;
      images = journal.images;
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
    DateTime time = journal.time;
    int serverId = journal.serverId;

    Journal savedJournal = Journal(id, body, time, images ?? images, serverId);

    if (isNewJournal) {
      context.read<JournalBloc>()
        ..add(AddJournalEvent(savedJournal))
      ;
    } else {
      context.read<JournalBloc>()
        ..add(EditJournalEvent(savedJournal))
      ;
    }
  }

  void viewJournalAfterSave(BuildContext context, Journal savedJournal) {
    Navigator.pushReplacementNamed(context, ViewJournalScreen.routeName,
        arguments: {"journal": savedJournal, "screen": HomeScreen.routeName});
  }

  void showErrorMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("There was an error saving this journal")));
  }

  void openDatePicker(BuildContext context) async {
    var date = await showDatePicker(
        context: context,
        initialDate: journal.time,
        firstDate: DateTime(2010),
        lastDate: DateTime(DateTime.now().year + 3));
    if (date == null) {
      return;
    }
    setState(() {
      journal = Journal(
          journal.id,
          journal.body,
          DateTime(date.year, date.month, date.day, journal.time.hour,
              journal.time.minute, journal.time.second));
    });
  }

  void openTimePicker(BuildContext context) async {
    var time = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(journal.time));
    if (time == null) {
      return;
    }
    setState(() {
      journal = Journal(
          journal.id,
          journal.body,
          DateTime(journal.time.year, journal.time.month, journal.time.month,
              time.hour, time.minute, journal.time.second));
    });
  }

  void setHasContent(String val) {
    {
      if (val == null || val.isEmpty) {
        setState(() {
          hasContent = false;
        });
      } else {
        setState(() {
          hasContent = true;
        });
      }
    }
  }

  void selectImage() async {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return Dialog(
                insetPadding: EdgeInsets.all(10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 280,
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Add Pictures",
                          style: Theme.of(context).textTheme.headline1.copyWith(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () => pickImage("gallery", setState),
                              child: Container(
                                height: 100,
                                width: 100,
                                color: Colors.black.withOpacity(0.6),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.photo,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Gallery",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            .copyWith(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () => pickImage("camera", setState),
                              child: Container(
                                height: 100,
                                width: 100,
                                color: Colors.black.withOpacity(0.6),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.camera,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Camera",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            .copyWith(
                                              fontSize: 15,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (images != null)
                        Expanded(
                          child: Container(
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Wrap(

                                spacing: 20,
                                runSpacing: 20,
                                clipBehavior: Clip.none,
                                children: images.map((image) {
                                  return Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Container(
                                            child: Image.memory(
                                              image,
                                              height: 100,width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: -10,
                                            right: -10,
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.red,
//                                          shape: BoxShape.circle,
                                              ),
                                              child: GestureDetector(
                                                onTap: () => removeImage(
                                                    image, setState),
                                                child: FittedBox(
                                                  child: Icon(
                                                      Icons.clear,
                                                      color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ]),
                                  );
                                }).toList()),
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "OK",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).then((_) {
      if (images != null) {
        if (images.length == 0) {
          images = null;
        }
      }
    });
  }

  void pickImage(String type, setState) async {
    PickedFile pickedFile;

    if (type == "gallery") {
      pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    }
    if (type == "camera") {
      pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    }

    if (pickedFile != null) {
      var bytes = await pickedFile.readAsBytes();
      setState(() {
        if (images == null) {
          images = [];
        }
        images.add(bytes);
      });
    }
  }

  void removeImage(Uint8List image, setState) {
    setState(() {
      images.remove(image);
//      images.removeAt(index);
    });
  }
}
