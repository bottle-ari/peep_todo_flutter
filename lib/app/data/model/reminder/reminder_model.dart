
class ReminderModel {
  final String id;
  String name;
  String icon;
  String ?ifCondition;
  String ?notifyCondition;
  int pos;

  ReminderModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.ifCondition,
    required this.notifyCondition,
    required this.pos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'if_condition': ifCondition,
      'notify_condition': notifyCondition,
      'pos': pos,
    };
  }

  factory ReminderModel.fromMap(Map<String, dynamic> map) {
    return ReminderModel(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
      ifCondition: map['if_condition'],
      notifyCondition: map['notify_condition'],
      pos: map['pos'],
    );
  }
}
