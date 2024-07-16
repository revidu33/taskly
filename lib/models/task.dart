class Task {
  int? id;
  String title;
  String description;
  String dueDate;
  int? isCompleted;

  Task(
      {this.id,
      required this.title,
      required this.description,
      required this.dueDate,
      required isCompleted});

  set(bool isComplete) {
    if (isComplete == true) {
      isCompleted = 1;
    } else {
      isCompleted = 0;
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'isCompleted': isCompleted,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Task.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        dueDate = map['dueDate'],
        isCompleted = map['isCompleted'];
}
