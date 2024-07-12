class Comment {
  int? id;
  int taskId;
  String comment;

  Comment({this.id, required this.taskId, required this.comment});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'taskId': taskId,
      'comment': comment,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Comment.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        taskId = map['taskId'],
        comment = map['comment'];
}
