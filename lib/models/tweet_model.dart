import 'package:cloud_firestore/cloud_firestore.dart';


class Tweet {
  Tweet({
    this.id,
    this.body,
    this.createdAt,
  });

  String? id;
  String? body;
  Timestamp? createdAt;

  factory Tweet.fromDocumentSnapshot(DocumentSnapshot doc) => Tweet(
    id: doc.id,
    body: doc["body"],
    createdAt: doc["created_at"]
  );
}
