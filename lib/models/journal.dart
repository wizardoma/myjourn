class Journal {
  String _id;
  String _body;
  DateTime _date;

  Journal(this._id, this._body, this._date);

  String get id => _id;

  String get body => _body;

  set id(String value) {
    _id = value;
  }

  set body(String body) {
    this._body = body;
  }

  DateTime get time => _date;

  set time(DateTime value) {
    _date = value;
  }
}
