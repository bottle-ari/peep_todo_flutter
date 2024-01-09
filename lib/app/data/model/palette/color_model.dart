import 'dart:ui';

class ColorModel {
  final String id;
  Color color;

  ColorModel({required this.id, required this.color});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'color': color.value.toRadixString(16).substring(2, 8).toUpperCase(),
    };
  }

  factory ColorModel.fromMap(Map<String, dynamic> map) {
    return ColorModel(
      id: map['id'],
      color: Color(int.parse("0xFF${map['color']}")),
    );
  }
}
