import 'dart:ui';

import 'package:peep_todo_flutter/app/data/model/palette/color_model.dart';

class PaletteModel {
  final String id;
  String name;
  int primaryColor;
  List<ColorModel> colors;

  PaletteModel({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.colors,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'primary_color': primaryColor,
    };
  }

  factory PaletteModel.fromMap(Map<String, dynamic> map) {
    return PaletteModel(
        id: map['id'],
        name: map['name'],
        primaryColor: map['primary_color'],
        colors: [],);
  }
}
