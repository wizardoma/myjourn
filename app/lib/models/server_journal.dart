class ServerJournal {
  int _id;

  int _dbId;
  String _body;
  String _date;
  List<String> _images;

  ServerJournal(this._id, this._dbId, this._body, this._date, this._images);

  factory ServerJournal.fromMap(Map<String, dynamic> map) {
    return new ServerJournal(
      map['_id'] as int,
      map['_dbId'] as int,
      map['_body'] as String,
      map['_date'] as String,
      map['_images'] as List<String>,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this._id,
      'dbId': this._dbId,
      'body': this._body,
      'date': this._date,
      'images': this._images,
    } as Map<String, dynamic>;
  }

  List<String> get images => _images;

  set images(List<String> value) {
    _images = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get body => _body;

  set body(String value) {
    _body = value;
  }

  int get dbId => _dbId;

  set dbId(int value) {
    _dbId = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
