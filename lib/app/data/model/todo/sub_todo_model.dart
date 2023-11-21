class SubTodoModel {
  final String name;
  final bool isChecked;

  SubTodoModel({required this.name, required this.isChecked});

  Map<String, dynamic> toMap() {
    return {
      'text': name,
      'isChecked': isChecked ? 1 : 0,
    };
  }

  factory SubTodoModel.fromMap(Map<String, dynamic> map) {
    return SubTodoModel(
      name: map['name'],
      isChecked: (map['is_checked'] == 1),
    );
  }
}
