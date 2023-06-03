import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  late String id;
  late String title;
  late bool isCompleted;
  late String description;
  late Timestamp createdAt;
  late String uid;
  DocumentReference? refrence;
  TodoModel(
      {required this.id,
      required this.title,
      required this.uid,
      required this.createdAt,
      required this.description,
      required this.isCompleted,
      this.refrence});

  TodoModel.fromMap(Map<String, dynamic> data, {this.refrence}) {
    id = data["id"];
    title = data["title"];
    isCompleted = data["isCompleted"];
    uid = data["uid"];
    createdAt = data["createdAt"];
    description = data["description"];
  }

  TodoModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            refrence: snapshot.reference);

  toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'uid': uid,
      'createdAt': createdAt,
      'description': description,
    };
  }
}
