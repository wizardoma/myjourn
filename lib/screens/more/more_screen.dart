import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  final navs = [
    {
      "icon": Icons.settings,
      "title": "Settings",
    },
    {
      "icon": Icons.web,
      "title": "Connect Google Assistant",
    },
    {
      "icon": Icons.web,
      "title": "Connect Amazon Alexa",
    },
    {
      "icon": Icons.tv,
      "title": "Myjourn Web/Desktop",
    },
    {
      "icon": Icons.feedback,
      "title": "Feedback Support",
    },
    {
      "icon": Icons.rate_review,
      "title": "Rate Myjourn",
    },
    {
      "icon": Icons.people,
      "title": "Tell a Friend",
    },
    {
      "icon": Icons.shield,
      "title": "Privacy Policy",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                elevation: 1,
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Go Premium",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Get a better version of Myjourn",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(fontSize: 15),
                              )
                            ]),
                        Icon(
                          Icons.star,
                          size: 40,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ListView(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: navs.map((e) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200)),
                    child: ListTile(
                      leading: Icon(e["icon"]),
                      title: Text(e["title"]),
                    ),
                  );
                }).toList(),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        child: Center(child: Text("Follow us on")),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/logos/facebook.png"),
                            Image.asset("assets/logos/instagram.png"),
                            Image.asset("assets/logos/twitter.png"),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "Version: 1.0.0",
                        style: Theme.of(context).textTheme.headline3,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
