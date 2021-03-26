import 'package:flutter/material.dart';
import 'package:flutterfrontend/providers/ThemeProvider.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SettingsList(
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        sections: [
          SettingsSection(
            title: "Premium",
            tiles: [
              SettingsTile(
                title: "MyJourn Premium",
              ),
            ],
          ),
          SettingsSection(
            subtitlePadding: EdgeInsets.only(bottom: 20),
            title: "Security",
            tiles: [
              SettingsTile.switchTile(
                title: "Security Code",
                onToggle: (bool value) {},
                switchValue: false,
                subtitle: "Set security code to lock this app",
              ),
              SettingsTile(
                title: "Security Code Timeout",
                subtitle: "After 5 minutes",
              ),
            ],
          ),
          SettingsSection(
            title: "Daily Reminder",
            tiles: [
              SettingsTile.switchTile(
                title: "Daily Reminder",
                onToggle: (bool value) {},
                switchValue: true,
                subtitle: "Set daily journaling MyJourn reminder",
              ),
              SettingsTile(
                title: "Daily Reminder Timeout",
                subtitle: "20 : 30",
              ),
              SettingsTile.switchTile(
                title: "Inspiring quote",
                onToggle: (bool value) {},
                switchValue: true,
                subtitle: "Receive Inspiring quote with the reminder",
              ),
            ],
          ),
          SettingsSection(
            title: "Color Theme",
            tiles: [
              SettingsTile(
                title: "Theme",
                subtitle: "Change themes (Includes Dark theme)",
                onPressed: (context) => changeTheme(context),
              ),
            ],
          ),
          SettingsSection(
            title: "Font and Size",
            tiles: [
              SettingsTile(
                title: "Font",
                subtitle: "Roboto-Regular",
              ),
              SettingsTile(
                title: "Size",
                subtitle: "Normal",
              ),
            ],
          ),
          SettingsSection(
            title: "Login",
            tiles: [
              SettingsTile(
                leading: Image.asset("assets/logos/google.png"),
                title: "alibekason@gmail.com",
              ),
              SettingsTile(
                title: "Logout",
              )
            ],
          ),
          SettingsSection(
            title: "Privacy",
            tiles: [
              SettingsTile(
                leading: Icon(Icons.file_download),
                title: "Data Download",
              ),
              SettingsTile(
                leading: Icon(Icons.delete_forever),
                title: "Delete my account",
              )
            ],
          ),
        ],
      ),
    );
  }

  void changeTheme(BuildContext context) async {
    var selectedTheme =
        await Provider.of<ThemeProvider>(context, listen: false).currentTheme;
    showDialog(
        context: context,
        builder: (context) {
          var themes = Provider.of<ThemeProvider>(context);

          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Theme",
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: GridView.builder(
                            itemCount: themes.themes.length,
                            padding: EdgeInsets.all(15),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 5,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30),
                            itemBuilder: (context, index) {
                              var indexedKey = themes.themes.entries
                                  .toList()
                                  .elementAt(index)
                                  .key;
                              var indexedTheme =
                                  themes.themes.values.toList()[index];
                              return InkWell(
                                onTap: () {
                                  setState(() => selectedTheme = indexedKey);
                                },
                                child: Stack(children: [
                                  Container(
                                    color: indexedTheme.primaryColor,
                                  ),
                                  if (indexedKey == selectedTheme)
                                    Positioned(
                                      right: 200,
                                      child: Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.white,
                                      ),
                                    )
                                ]),
                              );
                            }),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text("Choose"),
                        onPressed: () {
                          Navigator.pop(context, selectedTheme);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).then((value) {
      var theme = value as String;
      Provider.of<ThemeProvider>(context, listen: false).theme = theme;
    });
  }
}