import 'dart:ui';

class CategoryModel {
  final int id;
  final int userId;
  final String name;
  final Color color;
  final String emoji;
  final int order;

  CategoryModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.color,
    required this.emoji,
    required this.order,
  });
}
