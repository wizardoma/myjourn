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

  static Journal fromNewMap(Map<String, dynamic> data){
    var id = data["id"];
    var body = data["body"];
    var date = data["date"];

    if (data["images"] !=null) {
      return Journal(id, body, date);
    }
    return Journal(id, body, date);

  }

  Journal.fromMap(Map<String, dynamic> data)
      : _id = data["id"],
        _body = data["body"],
        _date = DateTime.fromMillisecondsSinceEpoch(data["date"]),
        _images = data["images"] != null
            ? (data["images"] as String).split("|").map((e) {
              return base64Decode(e);
            }).toList()
            : null;

  static Map<String, dynamic> toMap(Journal journal) {

    var joinedImage = journal.images.map((e) => base64Encode(e)).join("|");

    return {
      "id": journal.id,
      "body": journal.body,
      "date": journal._date.millisecondsSinceEpoch,
      "images": journal.images != null || journal.images.length > 0
          ? joinedImage
          : null
    };
  }

  @override
  String toString() {
    return 'Journal{_id: $_id, _body: $_body, _date: $_date}';
  }
}
