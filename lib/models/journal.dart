import 'dart:convert';
import 'dart:typed_data';

class Journal {
  int _id;
  String _body;
  List<Uint8List> _images;
  DateTime _date;

  Journal(this._id, this._body, this._date, [this._images]);

  set images(List<Uint8List> images) {
    this._images = images;
  }

  List<Uint8List> get images {
    return _images;
  }

  int get id => _id;

  String get body => _body;

  set id(int value) {
    _id = value;
  }

  set body(String body) {
    this._body = body;
  }

  DateTime get time => _date;

  set time(DateTime value) {
    _date = value;
  }

  static Journal fromNewMap(Map<String, dynamic> data) {
    var id = data["id"];
    var body = data["body"];
    var date = DateTime.fromMillisecondsSinceEpoch(data["date"]);
    if (data["images"] != null) {
      return Journal(
          id,
          body,
          date,
          (data["images"] as String).split("|").map((e) {
            return base64Decode(e);
          }).toList());
    }

    return Journal(id, body, date);
  }

  static Map<String, dynamic> toMap(Journal journal) {
    var id = journal.id;
    var body = journal.body;
    var date = journal.time.millisecondsSinceEpoch;
    print(journal.images==null);
    var hasImage = journal.images != null;
    if (hasImage) {
      var joinedImage = journal.images.map((e) => base64Encode(e)).join("|");
      return {"id": id, "body": body, "date": date, "images": joinedImage};
    }

    return {"id": id, "body": body, "date": date};
  }

  @override
  String toString() {
    return 'Journal{_id: $_id, _body: $_body, _date: $_date , _images: $_images}';
  }
}
