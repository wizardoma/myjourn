import 'package:shared_preferences/shared_preferences.dart';

class JournalPreferences {
  static final _journalServerSync = "server_sync";

  setServerSync(bool sync) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool(_journalServerSync, sync);
  }

  getServerSync() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(_journalServerSync);
  }

}
