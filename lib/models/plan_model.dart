import 'package:firebase_database/firebase_database.dart';

class Plan {
  String userId;
  String key;
  String title;
  String date;
  String content;
  String imgUrl;
  bool completed;

  Plan(this.userId, this.title, this.date, this.content, this.imgUrl, this.completed);

  Plan.fromSnapshot(DataSnapshot snapshot):
        key = snapshot.key,
        userId = snapshot.value['userId'],
        title = snapshot.value['title'],
        date = snapshot.value['date'],
        content = snapshot.value['content'],
        imgUrl = snapshot.value['imgUrl'],
        completed = snapshot.value['completed'];

  Map<String, dynamic> toJson() => {
    'userId' : userId,
    'title' : title,
    'date' : date,
    'content' : content,
    'imgUrl' : imgUrl,
    "completed" : completed
  };

}