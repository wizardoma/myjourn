import 'package:flutter/material.dart';
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
}
