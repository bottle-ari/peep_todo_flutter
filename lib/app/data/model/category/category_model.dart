import 'dart:ui';

import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';

class CategoryModel {
  final String id;
  String name;
  int color;
  String emoji;
  TodoType type;
  bool isActive;
  int pos;

  CategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.emoji,
    required this.type,
    required this.isActive,
    required this.pos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'emoji': emoji,
      'type': type.index,
      'is_active': isActive ? 1 : 0,
      'pos': pos,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        id: map['id'],
        name: map['name'],
        color: map['color'],
        emoji: map['emoji'],
        type: TodoType.values[map['type']],
        isActive: (map['is_active'] == 1),
        pos: map['pos']);
  }
}
