class Journal {
  int _id;
  String _body;
  DateTime _date;

  Journal(this._id, this._body, this._date);

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
      "body": journal.body,
      "date": journal._date.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return 'Journal{_id: $_id, _body: $_body, _date: $_date}';
  }
}
