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

  Journal.fromMap(Map<String, dynamic> data)
      : _id = data["id"],
        _body = data["body"],
        _date = DateTime.fromMillisecondsSinceEpoch(data["date"]);

  static Map<String, dynamic> toMap(Journal journal) {
    return {
      "id" : journal.id,
      "body": journal.body,
      "date": journal._date.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return 'Journal{_id: $_id, _body: $_body, _date: $_date}';
  }
}
