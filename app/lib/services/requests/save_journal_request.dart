class CreateServerJournalRequest {
  final int dbId;
  final String body;
  final List<String> images;
  final String date;

  CreateServerJournalRequest({this.dbId, this.body, this.images, this.date});

  factory CreateServerJournalRequest.fromMap(Map<String, dynamic> map) {
    return new CreateServerJournalRequest(
      dbId: map['dbId'] as int,
      body: map['body'] as String,
      images: map['images'] as List<String>,
      date: map['date'] as String,
    );
  }

  factory CreateServerJournalRequest.fromJournal(Map<String, dynamic> journalMap){
    var images = journalMap["images"];
    var dbID = journalMap["id"] as int;
    var journalBody = journalMap["body"] as String;
    var journalDate = journalMap["date"].toString();
    if (images != null) {
      return new CreateServerJournalRequest(
        dbId: dbID,
        body: journalBody,
        images: null,
        date: journalDate,
      );
    }
    return new CreateServerJournalRequest(
      dbId: dbID,
      body: journalBody,
      images: journalMap["images"] as List<String>,
      date: journalDate,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'dbId': this.dbId,
      'body': this.body,
      'images': this.images,
      'date': this.date,
    } as Map<String, dynamic>;
  }
}
