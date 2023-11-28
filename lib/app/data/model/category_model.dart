import 'dart:ui';

class CategoryModel {
  final String id;
  String name;
  Color color;
  String emoji;
  int pos;

  CategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.emoji,
    required this.pos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color.value.toRadixString(16).substring(2, 8).toUpperCase(),
      'emoji': emoji,
      'pos': pos,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        id: map['id'],
        name: map['name'],
        color: Color(int.parse("0xFF${map['color']}")),
        emoji: map['emoji'],
        pos: map['pos']);
  }
}
