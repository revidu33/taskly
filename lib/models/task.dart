class Task {
  int? id;
  String title;
  String description;
  String dueDate;
  bool? _isComplete;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDate,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'description': description,
      'dueDate': dueDate,
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
        dueDate = map['dueDate'];
}
