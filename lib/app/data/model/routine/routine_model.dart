
class RoutineModel {
  final String id;
  String categoryId;
  String? reminderId;
  String name;
  bool isActive;
  int priority;
  String repeatCondition;
  int pos;

  RoutineModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.isActive,
    required this.priority,
    required this.repeatCondition,
    required this.pos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'is_active': isActive,
      'priority': priority,
      'repeat_condition': repeatCondition,
      'pos': pos,
    };
  }

  factory RoutineModel.fromMap(Map<String, dynamic> map) {
    return RoutineModel(
      id: map['id'],
      categoryId: map['category_id'],
      name: map['name'],
      isActive: (map['is_active'] == 1),
      priority: map['priority'],
      repeatCondition: map['repeat_condition'],
      pos: map['pos'],
    );
  }
}
