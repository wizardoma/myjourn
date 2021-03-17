class Journal {
  String _id;
  String _body;
  DateTime _time;

  Journal(this._id, this._body, this._time);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  set body(String body) {
    this._body = body;
  }

  DateTime get time => _time;

  set time(DateTime value) {
    _time = value;
  }
}
