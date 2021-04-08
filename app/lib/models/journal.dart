import 'dart:convert';
import 'dart:typed_data';

class Journal {
  int _id;
  int _serverId;
  String _body;
  List<Uint8List> _images;
  DateTime _date;

  Journal(this._id, this._body, this._date, [this._images, this._serverId]);

  set images(List<Uint8List> images) {
    this._images = images;
  }

  List<Uint8List> get images {
    return _images;
  }

  int get serverId => _serverId;

  set serverId(int value) {
    _serverId = value;
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

  static Journal fromMap(Map<String, dynamic> data) {
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


  Map<String, dynamic> toMap() {
    var id = this.id;
    var body = this.body;
    var date = this.time.millisecondsSinceEpoch;
    var hasImage = this.images != null;
    if (hasImage) {
      var joinedImage = this.images.map((e) => base64Encode(e)).join("|");
      return {"id": id, "body": body, "date": date, "images": joinedImage, "serverId": this.serverId};
    }

    return {"id": id, "body": body, "date": date, "serverId": this.serverId};
  }

  @override
  String toString() {
    return 'Journal{_id: $_id, _body: $_body, _date: $_date , _images: $_images , _serverId: $_serverId}';
  }
}
