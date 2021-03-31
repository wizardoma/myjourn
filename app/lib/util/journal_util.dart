
import 'package:flutterfrontend/models/journal.dart';

mixin JournalUtils {

  Map<DateTime, List<Journal>> listToMapView(List<Journal> journals) {
    if (journals == null || journals.length == 0) {
      return {};
    }
    Map<DateTime, List<Journal>> result = {};
    journals.map((e) {
      // have a distinct year, month and day in map
      return result.putIfAbsent(DateTime(e.time.year, e.time.month, e.time.day), () {
        return journals.where((journal) {
          // filter journals that correspond with the current date
         return journal.time.year == e.time.year && journal.time.month == e.time.month && journal.time.day == e.time.day;
        }).toList();
      });
    }).toList();

    return result;

  }
}