import 'dart:ui';

class DiaryTodoModel {
  String name;
  Color color;

  DiaryTodoModel({required this.name, required this.color});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color.value.toRadixString(16).substring(2, 8).toUpperCase(),
    };
  }

  factory DiaryTodoModel.fromMap(Map<String, dynamic> map) {
    return DiaryTodoModel(
      name: map['name'],
      color: Color(int.parse("0xFF${map['color']}")),
    );
  }
}
