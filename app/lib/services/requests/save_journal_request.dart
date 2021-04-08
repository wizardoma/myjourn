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

  factory CreateServerJournalRequest.fromJournalMap(Map<String, dynamic> journalMap){
    return new CreateServerJournalRequest(
      dbId: journalMap["id"] as int,
      body: journalMap["body"] as String,
      images: journalMap["images"] as List<String>,
      date: journalMap["date"] as String,
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
