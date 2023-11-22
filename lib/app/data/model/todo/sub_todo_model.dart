class SubTodoModel {
  final int id;
  String name;
  bool isChecked;

  SubTodoModel({required this.id, required this.name, required this.isChecked});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': name,
      'isChecked': isChecked ? 1 : 0,
    };
  }

  factory SubTodoModel.fromMap(Map<String, dynamic> map) {
    return SubTodoModel(
      id: map['id'],
      name: map['name'],
      isChecked: (map['is_checked'] == 1),
    );
  }
}
