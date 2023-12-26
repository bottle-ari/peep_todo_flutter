class TodoModel {
  final String id;
  String categoryId;
  String? reminderId;
  String name;
  DateTime? date;
  int priority;
  String? memo;
  bool isChecked;
  DateTime? checkTime;
  int pos;

  TodoModel({
    required this.id,
    required this.categoryId,
    required this.reminderId,
    required this.name,
    required this.date,
    required this.priority,
    required this.memo,
    required this.isChecked,
    required this.checkTime,
    required this.pos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'reminder_id': reminderId,
      'name': name,
      'date': date?.millisecondsSinceEpoch,
      'priority': priority,
      'memo': memo,
      'is_checked': isChecked ? 1 : 0,
      'check_time': checkTime?.millisecondsSinceEpoch,
      'pos': pos,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      categoryId: map['category_id'],
      reminderId: map['reminder_id'],
      name: map['name'],
      date: map['date'] == null ? null : DateTime.fromMillisecondsSinceEpoch(map['date']),
      priority: map['priority'],
      memo: map['memo'],
      isChecked: (map['is_checked'] == 1),
      checkTime: map['check_time'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(map['check_time']),
      pos: map['pos'],
    );
  }
}
